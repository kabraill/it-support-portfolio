<#
.SYNOPSIS
    A menu-driven help desk toolkit for quick Windows diagnostics.

.DESCRIPTION
    Shows system info, disk space and a network check, can flush the DNS cache
    and renew the IP address (both ask for confirmation first), and can save
    a full report to a text file.

    Admin rights: NOT needed for options 1, 2, 3, 6 and 7.
    Admin rights: needed for options 4 and 5 (Windows requires it for
    "ipconfig /flushdns" and "ipconfig /renew"). The script tells you if you
    are not an administrator.

.PARAMETER Option
    Optional. Run one read-only option (1, 2, 3 or 6) and exit without the menu.
    Handy for testing. Leave it out to use the normal menu.

.PARAMETER ReportFolder
    Optional. Where option 6 saves the report. Default: a "reports" folder
    next to this script.

.EXAMPLE
    .\SupportToolkit.ps1
#>

# --- Section 0: Parameters ---------------------------------------------------
# These are the optional settings you can give the script when you start it.
param(
    [ValidateSet(0, 1, 2, 3, 6)]
    [int]$Option = 0,

    [string]$ReportFolder = (Join-Path $PSScriptRoot 'reports')
)

# --- Section 1: Settings -----------------------------------------------------
# A disk is "low" when less than this percentage of it is free.
$LowDiskPercent = 15

# --- Section 2: Small helper functions --------------------------------------

# Checks if PowerShell is running as administrator. Returns True or False.
function Test-IsAdmin {
    $identity  = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Asks a yes/no question. Returns True only if the user types Y or YES.
function Confirm-Action {
    param([string]$Question)
    $answer = Read-Host "$Question (Y/N)"
    return ($answer -match '^(y|yes)$')
}

# Sends one or two pings to a target. Returns True if it answers, otherwise False.
function Test-Ping {
    param([string]$Target)
    try {
        return [bool](Test-Connection -ComputerName $Target -Count 2 -Quiet -ErrorAction Stop)
    }
    catch {
        return $false
    }
}

# Prints lines on screen. Lines that start with [OK] are green, [FAIL] red
# and [WARN] yellow, so problems are easy to see.
function Show-Lines {
    param([string[]]$Lines)
    foreach ($line in $Lines) {
        if ($line -like '[[]OK]*')        { Write-Host $line -ForegroundColor Green }
        elseif ($line -like '[[]FAIL]*')  { Write-Host $line -ForegroundColor Red }
        elseif ($line -like '[[]WARN]*')  { Write-Host $line -ForegroundColor Yellow }
        else                              { Write-Host $line }
    }
}

# --- Section 3: Option 1 - System information -------------------------------
# Collects basic facts about this computer and returns them as text lines.
function Get-SystemInfoLines {
    $lines = @()
    $lines += '=== System information ==='

    # Operating system details come from WMI/CIM (Windows' information store).
    $os  = Get-CimInstance -ClassName Win32_OperatingSystem
    $cpu = Get-CimInstance -ClassName Win32_Processor | Select-Object -First 1

    # Uptime = now minus the time of the last start.
    $uptime = (Get-Date) - $os.LastBootUpTime
    $uptimeText = '{0} days, {1} hours, {2} minutes' -f $uptime.Days, $uptime.Hours, $uptime.Minutes

    # Memory is reported in KB, so divide to get GB.
    $totalRamGb = [math]::Round($os.TotalVisibleMemorySize / 1MB, 1)
    $freeRamGb  = [math]::Round($os.FreePhysicalMemory / 1MB, 1)

    $lines += "Computer name : $env:COMPUTERNAME"
    $lines += "User          : $env:USERNAME"
    $lines += "OS version    : $($os.Caption) (version $($os.Version), build $($os.BuildNumber))"
    $lines += "Uptime        : $uptimeText"
    $lines += "RAM           : $totalRamGb GB total, $freeRamGb GB free"
    $lines += "CPU           : $($cpu.Name.Trim()) ($($cpu.NumberOfCores) cores, $($cpu.NumberOfLogicalProcessors) threads)"
    return $lines
}

# --- Section 4: Option 2 - Disk space ---------------------------------------
# Lists every local and removable drive with its free space.
# Adds a warning when free space is under 15 percent.
function Get-DiskLines {
    $lines = @()
    $lines += '=== Disk space ==='

    # DriveType 2 = removable (USB), 3 = local disk. Skip drives with no size.
    $disks = Get-CimInstance -ClassName Win32_LogicalDisk |
             Where-Object { ($_.DriveType -eq 2 -or $_.DriveType -eq 3) -and $_.Size -gt 0 }

    foreach ($disk in $disks) {
        $sizeGb    = [math]::Round($disk.Size / 1GB, 1)
        $freeGb    = [math]::Round($disk.FreeSpace / 1GB, 1)
        $freePct   = [math]::Round(($disk.FreeSpace / $disk.Size) * 100, 1)
        $text      = "$($disk.DeviceID) $freeGb GB free of $sizeGb GB ($freePct% free)"

        if ($freePct -lt $LowDiskPercent) {
            $lines += "[WARN] $text - LOW, under $LowDiskPercent% free"
        }
        else {
            $lines += "[OK]   $text"
        }
    }
    return $lines
}

# --- Section 5: Option 3 - Network check ------------------------------------
# Runs a few simple tests in a logical order and shows OK or FAIL for each.
function Get-NetworkLines {
    $lines = @()
    $lines += '=== Network check ==='

    # Find the network connection that has a default gateway (the one in use).
    $config = Get-NetIPConfiguration -ErrorAction SilentlyContinue |
              Where-Object { $_.IPv4DefaultGateway } |
              Select-Object -First 1

    $ip      = $null
    $gateway = $null
    $dns     = $null

    if ($config) {
        $ip      = $config.IPv4Address | Select-Object -First 1 -ExpandProperty IPAddress
        $gateway = $config.IPv4DefaultGateway | Select-Object -First 1 -ExpandProperty NextHop
        $dns     = ($config.DNSServer | Where-Object { $_.AddressFamily -eq 2 }).ServerAddresses
    }

    # Test 1: Does the PC have a proper IP address?
    # An address starting with 169.254 means DHCP did not answer.
    if (-not $ip) {
        $lines += '[FAIL] IP address         : none found (no connection with a default gateway)'
    }
    elseif ($ip -like '169.254.*') {
        $lines += "[FAIL] IP address         : $ip (169.254 = no DHCP answer, the PC gave itself an address)"
    }
    else {
        $lines += "[OK]   IP address         : $ip"
    }

    # Test 2: Is a default gateway (the router) set?
    if ($gateway) { $lines += "[OK]   Default gateway    : $gateway" }
    else          { $lines += '[FAIL] Default gateway    : none' }

    # Test 3: Are DNS servers set? (They turn names into IP addresses.)
    if ($dns) { $lines += "[OK]   DNS servers        : $($dns -join ', ')" }
    else      { $lines += '[FAIL] DNS servers        : none' }

    # Test 4: Can we ping the gateway? This tests the local network.
    if ($gateway) {
        if (Test-Ping -Target $gateway) { $lines += "[OK]   Ping gateway       : $gateway answers" }
        else                            { $lines += "[FAIL] Ping gateway       : $gateway does not answer" }
    }
    else {
        $lines += '[FAIL] Ping gateway       : skipped, no gateway'
    }

    # Test 5: Can we ping 8.8.8.8 (a public Google server)? This tests the internet.
    if (Test-Ping -Target '8.8.8.8') { $lines += '[OK]   Ping 8.8.8.8       : internet reachable' }
    else                             { $lines += '[FAIL] Ping 8.8.8.8       : no answer, internet not reachable' }

    # Test 6: Can we turn the name google.com into an IP address? This tests DNS.
    try {
        $result = Resolve-DnsName -Name 'google.com' -Type A -ErrorAction Stop |
                  Where-Object { $_.Type -eq 'A' } | Select-Object -First 1
        $lines += "[OK]   Resolve google.com : $($result.IPAddress)"
    }
    catch {
        $lines += '[FAIL] Resolve google.com : name could not be resolved (DNS problem)'
    }

    return $lines
}

# --- Section 6: Option 4 - Flush the DNS cache ------------------------------
# Clears the list of names the PC remembers. Needs administrator rights.
function Invoke-FlushDns {
    Write-Host '=== Flush DNS cache ==='
    Write-Host 'This clears the PC''s saved DNS answers. It is safe, but needs administrator rights.'

    if (-not (Confirm-Action -Question 'Do you want to flush the DNS cache now?')) {
        Write-Host 'Cancelled. Nothing was changed.'
        return
    }

    if (-not (Test-IsAdmin)) {
        Write-Host '[FAIL] You are not running as administrator. Open PowerShell with "Run as administrator" and try again.' -ForegroundColor Red
        return
    }

    # ipconfig /flushdns is the Windows command that clears the cache.
    # "Out-Host" prints the result on screen without mixing it into the menu logic.
    ipconfig /flushdns | Out-Host
}

# --- Section 7: Option 5 - Renew the IP address -----------------------------
# Asks the DHCP server for a new IP address. Needs administrator rights.
function Invoke-RenewIp {
    Write-Host '=== Renew IP address ==='
    Write-Host 'This asks the DHCP server for a new IP address. The connection may drop for a few seconds.'
    Write-Host 'It needs administrator rights.'

    if (-not (Confirm-Action -Question 'Do you want to renew the IP address now?')) {
        Write-Host 'Cancelled. Nothing was changed.'
        return
    }

    if (-not (Test-IsAdmin)) {
        Write-Host '[FAIL] You are not running as administrator. Open PowerShell with "Run as administrator" and try again.' -ForegroundColor Red
        return
    }

    # "release" gives the old address back, "renew" asks for a new one.
    # "Out-Host" prints the result on screen without mixing it into the menu logic.
    ipconfig /release | Out-Host
    ipconfig /renew | Out-Host
}

# --- Section 8: Option 6 - Save a full report -------------------------------
# Runs options 1, 2 and 3 and writes everything into one text file.
function Save-Report {
    Write-Host '=== Save report ==='

    # Make the report folder if it does not exist yet.
    if (-not (Test-Path -Path $ReportFolder)) {
        New-Item -Path $ReportFolder -ItemType Directory | Out-Null
    }

    # The file name contains the date and time so reports never overwrite each other.
    $stamp = Get-Date -Format 'yyyy-MM-dd_HH-mm-ss'
    $path  = Join-Path $ReportFolder "SupportReport_$stamp.txt"

    $report  = @()
    $report += 'Support Toolkit report'
    $report += "Created: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $report += "Run as administrator: $(Test-IsAdmin)"
    $report += ''
    $report += Get-SystemInfoLines
    $report += ''
    $report += Get-DiskLines
    $report += ''
    $report += Get-NetworkLines

    Set-Content -Path $path -Value $report -Encoding UTF8
    Write-Host "Report saved to: $path" -ForegroundColor Green
}

# --- Section 9: The menu ----------------------------------------------------
# Draws the menu on the screen.
function Show-Menu {
    Write-Host ''
    Write-Host '=============================='
    Write-Host '   Help Desk Support Toolkit'
    Write-Host '=============================='
    Write-Host '1) System info'
    Write-Host '2) Disk space'
    Write-Host '3) Network check'
    Write-Host '4) Flush DNS cache   (asks first, needs admin)'
    Write-Host '5) Renew IP address  (asks first, needs admin)'
    Write-Host '6) Save full report'
    Write-Host '7) Exit'
    Write-Host ''
}

# Runs the chosen option. Returns False when the user wants to exit.
function Invoke-Choice {
    param([string]$Choice)

    switch ($Choice) {
        '1' { Show-Lines (Get-SystemInfoLines) }
        '2' { Show-Lines (Get-DiskLines) }
        '3' { Show-Lines (Get-NetworkLines) }
        '4' { Invoke-FlushDns }
        '5' { Invoke-RenewIp }
        '6' { Save-Report }
        '7' { return $false }
        default { Write-Host 'Please type a number from 1 to 7.' -ForegroundColor Yellow }
    }
    return $true
}

# --- Section 10: Start of the program ---------------------------------------
# If -Option was given, run that one option and stop (no menu).
if ($Option -ne 0) {
    [void](Invoke-Choice -Choice ([string]$Option))
    return
}

# Otherwise show the menu again and again until the user picks 7.
$keepRunning = $true
while ($keepRunning) {
    Show-Menu
    $choice = Read-Host 'Choose an option (1-7)'
    Write-Host ''
    $keepRunning = Invoke-Choice -Choice $choice
    if ($keepRunning) {
        Write-Host ''
        [void](Read-Host 'Press Enter to go back to the menu')
    }
}

Write-Host 'Goodbye.'
