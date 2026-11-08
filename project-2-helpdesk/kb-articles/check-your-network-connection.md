# How to check your network connection

**Applies to:** Windows 11 PCs at Firma GmbH.

Use this guide when websites, Teams or shared folders do not work. It takes about five minutes.

## Step 1: Look at the basics

- Is the **network cable** plugged in at both ends? Or is **Wi-Fi** turned on and connected?
- Is **Airplane mode** off?
- Do other people near you have the same problem? If yes, tell the help desk straight away. It may be a bigger issue.

## Step 2: Restart

Restart your PC. This fixes many small problems.

## Step 3: Look at your IP address

1. Press the **Windows key**, type `cmd` and press Enter.
2. Type `ipconfig` and press Enter.
3. Look at **IPv4 Address** for your active connection (Ethernet or Wi-Fi).

| What you see | What it means |
|---|---|
| An address like `192.168.x.x` or `10.x.x.x` | You have a normal address. Continue with Step 4. |
| An address starting with **169.254** | Your PC did not get an address from the network (DHCP). Tell the help desk. |
| No address or "Media disconnected" | The cable or Wi-Fi is not connected. Check Step 1. |

## Step 4: Test the connection

In the same window, type these commands, one at a time:

1. `ping 127.0.0.1` : tests your own PC. This should work.
2. `ping <GATEWAY_IP>` : tests the connection to the office router (the **Default Gateway** shown by `ipconfig`).
3. `ping 8.8.8.8` : tests the internet.
4. `ping www.microsoft.com` : tests name lookup (DNS).

| Result | Likely meaning |
|---|---|
| 1 fails | A problem with your PC's network settings |
| 1 works, 2 fails | A problem between your PC and the office network |
| 2 works, 3 fails | The office internet connection is down |
| 3 works, 4 fails | A name lookup (DNS) problem |
| All work | The network is fine, so the problem is probably the program or website |

## Information to give the help desk

Please send us:

- what you were trying to do and the exact error message
- your IPv4 address (from `ipconfig`)
- which ping steps worked and which failed
- whether others around you are affected

Do not send any passwords.

## Do not

- change network settings if you are not sure
- install "network fixer" programs
