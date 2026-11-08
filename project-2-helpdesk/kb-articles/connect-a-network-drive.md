# How to connect a network drive

**Applies to:** Windows 11 PCs at Firma GmbH.

## What is a network drive?

A network drive is a shared folder on a company server. It looks like a normal drive in File Explorer (for example **Z:**), but the files are stored on the server, so your team can use them together.

## Usually it connects automatically

When you sign in on a company PC, the shared drive (**Z: Shared**) connects by itself. If you do not see it:

1. Make sure you are on the **company network** (in the office or on VPN).
2. Sign out and sign in again.
3. Open **Command Prompt** and type `gpupdate /force`, then press Enter. Wait for it to finish and sign out and in again.

## Connect it by hand

1. Open **File Explorer** and click **This PC**.
2. Click the three dots (**…**) in the toolbar and choose **Map network drive**.
3. Choose a drive letter, for example **Z:**.
4. In **Folder**, type the path, for example `\\SERVER\Shared`.
5. Tick **Reconnect at sign-in**, so the drive comes back after a restart.
6. Click **Finish**.

If you are asked for a user name and password, use your normal company sign-in.

## If it does not work

| What you see | What to try |
|---|---|
| "Network path not found" | Check your network connection (see the article "Check your network connection") |
| "Access denied" | You may not have permission. Ask the help desk for access |
| The drive has a red X | You are not connected to the network. Reconnect and click the drive again |
| The drive disappears after a restart | Re-map it and tick **Reconnect at sign-in** |

## Contact the help desk when

- the drive does not appear after you signed out and in again
- you get "Access denied" and need access to a folder
- the folder is full or very slow
