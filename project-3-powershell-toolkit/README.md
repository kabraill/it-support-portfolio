# Project 3: PowerShell Help Desk Toolkit

## What it does

`SupportToolkit.ps1` is a menu-driven PowerShell script for quick Windows diagnostics. It is the kind of tool a first-line help desk technician uses when a user says "my PC is slow" or "I have no internet". Every section of the script has a comment in simple English.

| Option | What it does | Admin rights |
|---|---|---|
| 1 | **System info:** computer name, user, OS version, uptime, RAM, CPU | No |
| 2 | **Disk space:** every local or USB drive, with a warning if less than 15% is free | No |
| 3 | **Network check:** IP address, gateway, DNS servers, ping the gateway, ping 8.8.8.8, resolve google.com. Each test shows `[OK]` or `[FAIL]` | No |
| 4 | **Flush DNS cache:** clears the PC's saved DNS answers. **Asks for confirmation first** | **Yes** |
| 5 | **Renew IP address:** gets a new address from DHCP. **Asks for confirmation first** | **Yes** |
| 6 | **Save a full report** (options 1, 2 and 3) to a text file in the `reports/` folder | No |
| 7 | **Exit** | No |

Options 4 and 5 change the network state of the PC, so the script asks "Y/N" before it does anything. Windows only lets administrators run `ipconfig /flushdns` and `ipconfig /renew`. If you are not an administrator, the script tells you and does nothing.

## How to run it

1. Open **Windows PowerShell** (press the Windows key, type `PowerShell`, press Enter).
2. Go to the project folder. For example:
   ```powershell
   cd "<PATH_TO>\project-3-powershell-toolkit"
   ```
3. Windows may block scripts by default. This command allows scripts **only in this PowerShell window**. The setting disappears when you close the window, and nothing else on your PC changes:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
4. Start the toolkit:
   ```powershell
   .\SupportToolkit.ps1
   ```
5. Type a number from 1 to 7 and press Enter.

**For options 4 and 5:** close the window and open PowerShell again with **Run as administrator** (right-click the PowerShell icon). Then repeat steps 2 to 4.

**Run one option without the menu** (read-only options only):

```powershell
.\SupportToolkit.ps1 -Option 3
```

## Example output

Computer and network details are replaced with placeholders here.

**Option 1: System info**

```
=== System information ===
Computer name : <COMPUTER_NAME>
User          : <USER_NAME>
OS version    : Microsoft Windows 11 Home (version 10.0.22631, build 22631)
Uptime        : 0 days, 2 hours, 36 minutes
RAM           : 15.8 GB total, 6 GB free
CPU           : <CPU_MODEL> (6 cores, 12 threads)
```

**Option 2: Disk space** (the warning shows when under 15% is free)

```
=== Disk space ===
[WARN] C: 3.3 GB free of 280.3 GB (1.2% free) - LOW, under 15% free
[OK]   D: 27.4 GB free of 177 GB (15.5% free)
```

**Option 3: Network check, everything working**

```
=== Network check ===
[OK]   IP address         : <IP_ADDRESS>
[OK]   Default gateway    : <GATEWAY_IP>
[OK]   DNS servers        : <DNS_IP>
[OK]   Ping gateway       : <GATEWAY_IP> answers
[OK]   Ping 8.8.8.8       : internet reachable
[OK]   Resolve google.com : <IP_ADDRESS_OF_GOOGLE>
```

**Option 3: a typical fault** (the PC could not get an address from DHCP)

```
=== Network check ===
[FAIL] IP address         : 169.254.x.x (169.254 = no DHCP answer, the PC gave itself an address)
[FAIL] Default gateway    : none
[FAIL] DNS servers        : none
[FAIL] Ping gateway       : skipped, no gateway
[FAIL] Ping 8.8.8.8       : no answer, internet not reachable
[FAIL] Resolve google.com : name could not be resolved (DNS problem)
```

**Option 4: confirmation before any change**

```
=== Flush DNS cache ===
This clears the PC's saved DNS answers. It is safe, but needs administrator rights.
Do you want to flush the DNS cache now? (Y/N): N
Cancelled. Nothing was changed.
```

## Reports

Option 6 saves a text file such as `reports/SupportReport_2026-11-08_22-24-21.txt`. The date and time are in the file name, so reports never overwrite each other. Reports contain the computer name and IP details, so the `.gitignore` keeps them out of Git.

## Reading the network check

The tests go from the PC outwards, so the first `[FAIL]` shows where the problem starts:

| Result | Likely problem |
|---|---|
| IP address starts with `169.254` | DHCP did not answer (cable, DHCP server or Wi-Fi) |
| Gateway ping fails | Problem on the local network (cable, switch, Wi-Fi) |
| Gateway works, `8.8.8.8` fails | Problem with the internet connection or the router |
| `8.8.8.8` works, `google.com` fails | DNS problem |

This matches the lab tickets in [Project 2](../project-2-helpdesk/README.md) (HELP-5: IP address starts with 169.254) and the DNS and DHCP parts of [Project 1](../project-1-ad-lab/README.md).

## Skills shown

- Writing a **menu-driven PowerShell script** with functions, parameters and a loop
- Reading system information with `Get-CimInstance`, and the network settings with `Get-NetIPConfiguration`
- Testing a connection in steps with `Test-Connection` (ping) and `Resolve-DnsName`
- Using the Windows commands `ipconfig /flushdns` and `ipconfig /renew` from a script
- **Safe scripting:** read-only checks by default, confirmation before changes, an administrator check, and no changes to system settings
- Saving results to a **text report** with a time stamp
- Explaining each step in simple language (every section is commented)

## Files

| File | Purpose |
|---|---|
| [`SupportToolkit.ps1`](SupportToolkit.ps1) | The toolkit |
| `reports/` | Where option 6 saves reports (the text files are not committed to Git) |
| [`.gitignore`](.gitignore) | Keeps saved reports out of Git |
