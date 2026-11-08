# Setup guide: rebuilding the AD lab in VirtualBox

This guide is for me, to rebuild the lab and take the missing or corrected screenshots. All work happens **inside the virtual machines**. Nothing here changes the host PC's settings, except creating the VMs in VirtualBox.

> **Rules:** never put real passwords in any file or screenshot. Use lab names (`labadmin`, `student1`), not real people's names. Blur anything personal before saving a screenshot.

## 1. What I need

| Item | Details |
|---|---|
| Hypervisor | Oracle VirtualBox (already installed) |
| Server ISO | Windows Server 2022 evaluation, 64-bit, English (Microsoft Evaluation Center) |
| Client ISO | Windows 11 Enterprise evaluation, 64-bit, English (Microsoft Evaluation Center) |
| Free disk space | About 120 GB (two VMs of 60 GB each, they grow as needed) |
| Free RAM | 8 GB or more, because both VMs run together |

The **Windows Server** evaluation lasts **180 days**, and the **Windows 11 Enterprise** evaluation lasts **90 days**. Write down the date I install each one, so I know when they end. Pick the normal "Windows 11 Enterprise" ISO (x64, English), not the LTSC one.

## 2. Create the server VM (`DC01`)

1. VirtualBox: **File → Preferences → Default Machine Folder**: choose a folder with plenty of space (for example on the E drive).
2. **New**: Name `DC01`, select the Server ISO, type *Microsoft Windows*, version *Windows 2022 (64-bit)*. Untick "Proceed with Unattended Installation" so I see the real installer.
3. Hardware: **4 GB RAM, 2 CPUs**. Disk: **60 GB**.
4. **Settings → Network → Adapter 1**: attached to **Internal Network**, name `labnet`.
5. Start the VM. When asked, choose **Windows Server 2022 Standard Evaluation (Desktop Experience)**. Do not pick the version without "Desktop Experience", because it has no graphical interface.
6. Set the Administrator password to `<PASSWORD>` (keep it somewhere private, not in this project).

## 3. Create the client VM (`CLIENT01`)

1. **New**: Name `CLIENT01`, select the Windows 11 ISO, version *Windows 11 (64-bit)*.
2. Hardware: **4 GB RAM, 2 CPUs**. Disk: **60 GB**.
3. **Settings → Network → Adapter 1**: **Internal Network**, name `labnet` (the same as the server).
4. If the Windows 11 installer says the PC does not meet requirements (TPM or Secure Boot), update VirtualBox first. Recent versions handle this.
5. Create a local user such as `labuser`. Do not use a real name.

> **Why Internal Network?** It connects only the lab VMs to each other. The server's DHCP cannot interfere with the home router. The VMs have no internet unless I add a second adapter set to NAT.
>
> **Internet for activation:** Microsoft says evaluation versions must activate over the internet within the first 10 days, or they shut down automatically. So on the **server VM**, add **Adapter 2 set to NAT** (Settings → Network → Adapter 2). Do the same on the client if it needs updates or activation. Keep Adapter 1 on `labnet` for the lab. When setting the static IP in Step A, change only the `labnet` adapter, and leave the NAT adapter on automatic (DHCP).

## 4. Build the lab in this order

### Step A: Server network (screenshots 01, 02)

1. On the server, open `ncpa.cpl`. Open Ethernet → Properties → IPv4.
2. Set a static IP, for example `192.168.10.10`, mask `255.255.255.0`. The gateway can stay empty on an internal network. Set the DNS server to `127.0.0.1`.
3. 📸 `01-static-ip-server.png`: the IPv4 properties window.
4. Open a terminal and run `ipconfig /all`. 📸 `02-ipconfig-all.png`.
5. Optional: rename the server (Server Manager → Local Server → Computer name) **before** installing AD DS, so every screenshot uses one name.

### Step B: Active Directory (screenshot 05)

1. Server Manager → **Add Roles and Features** → **Active Directory Domain Services**.
2. Promote the server to a Domain Controller: **Add a new forest**, root domain `EastCharmer.local`. Set the DSRM password to `<PASSWORD>` and keep it private.
3. After the restart, open **Active Directory Users and Computers**. Create the OU `USA` with child OUs `Users`, `Computers` and `Servers`. Create a test user `student1` in `USA/Users`. Create a group if useful.
4. 📸 `05-ad-users-and-computers.png`.

### Step C: DHCP (screenshots 21, 22, 23)

1. Add Roles and Features → **DHCP Server**. 📸 `21-dhcp-role-install.png`.
2. Click **Configure credentials**, then **Commit** (this authorises DHCP in AD).
3. Tools → **DHCP** → right-click **IPv4** → **New Scope**. Example range: `192.168.10.100` to `192.168.10.200`. Set the DNS option to the server's IP. 📸 `22-dhcp-new-scope.png`.
4. **Activate the scope**. 📸 `23-dhcp-scope-active.png`.
5. Record the values in the README's DHCP table.

### Step D: Client network and domain join (screenshots 03, 04, 06)

1. On the client, leave the adapter on **DHCP**. Run `ipconfig /all` and check that it received an address from the server.
2. Set the **preferred DNS server** to the server's IP. 📸 `03-client-dns-setting.png`.
3. Run `ping <SERVER_IP>`. 📸 `04-ping-test.png`.
4. Join the domain: Settings → System → About → **Domain or workgroup** (or `sysdm.cpl`) → `EastCharmer.local`. Sign in with the domain admin account. Restart.
5. 📸 `06-domain-join.png`: showing that the PC is joined to the domain.

### Step E: DNS (screenshots 24, 25, 26)

The DNS role is installed together with AD DS. Open **DNS Manager** (Tools → DNS).

1. 📸 `24-dns-manager.png`: the forward lookup zone `EastCharmer.local`.
2. Check or add the **A record** for the DC. 📸 `25-dns-a-record.png`.
3. On the client, run `nslookup EastCharmer.local`. 📸 `26-nslookup-test.png`.
4. Then complete the DNS section of the README (forward zone, reverse lookup zone, `nslookup` testing).

### Step F: File share (screenshot 13)

1. On the server, create `C:\Shared`. Share it with **Domain Users: Read**.
2. Put a test image in `C:\Shared` and name it `wallpaper.jpg`.
3. 📸 `13-share-permissions.png` (retake if needed).

### Step G: Group Policies (retake screenshots 07, 08, 09, 10, 11)

Use clear GPO names without typos.

1. **Password policy:** edit the *Default Domain Policy* (linked to the domain). 📸 `07-gpo-password-policy.png`.
2. **Account lockout:** a threshold of **5 to 10** (for example 5). Name the GPO "Brute Force Attack Prevention". 📸 `08-gpo-account-lockout.png`. Remember the policy only applies at the domain level.
3. **Drive map:** User Configuration → Preferences → Drive Maps → `\\<SERVER_NAME>\Shared` as `Z:`. Tick **Reconnect**. 📸 `09-gpo-drive-map.png`.
4. **Wallpaper:** use the UNC path `\\<SERVER_NAME>\Shared\wallpaper.jpg`. 📸 `10-gpo-wallpaper.png`.
5. **Control Panel:** a GPO named "Control Panel No Access", linked to `USA/Users`. 📸 `11-gpo-control-panel-policy.png`.
6. On the client, sign in as `student1` and run `gpupdate /force`. Sign out and back in. Check:
   - 📸 `12-control-panel-blocked.png`: the Control Panel is blocked.
   - 📸 `16-gpo-mapped-drive.png`: drive `Z:` appears.
   - The wallpaper changes.
7. Test the lockout: enter a wrong password more times than the threshold, then check the account is locked in AD Users and Computers.

### Step H: Manual mapping (screenshots 14, 15)

Optional retake. On the client, use **Map network drive** with a different letter (for example `Y:`), once with and once without **Reconnect at sign-in**, and restart to see the difference. 📸 `14-map-network-drive.png`, `15-manual-mapped-drive.png`.

### Step I: FSRM (screenshots 17 to 20)

Only retake these if needed.

1. Add Roles and Features → **File Server Resource Manager**. 📸 `17-fsrm-role-install.png`.
2. Quota on `C:\Shared`: 100 MB, hard quota, warning at 80%. 📸 `18-fsrm-quota.png`.
3. File screen on `C:\Shared`: block audio/video, executable and image files (active screening). 📸 `19-fsrm-file-screen.png`.
4. From the client, copy a `.jpg` into the share. 📸 `20-file-blocked-in-share.png`.

## 5. After the screenshots

- Save each image in `screenshots/` with the exact file name above.
- Update the **Status** column in the README's screenshot checklist.
- Replace `<HYPERVISOR>` in the README with *Oracle VirtualBox*.
- Re-check every image for names, passwords and personal data.
- Take a **VirtualBox snapshot** of each VM after major steps (AD installed, domain joined). Then I can go back if something breaks.
