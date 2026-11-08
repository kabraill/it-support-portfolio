# Corrections and what I learned

These are the mistakes I fixed when turning my lab notes into the README. Each one has the **mistake**, the **fix** and **why it matters**.

## Technical corrections

### 1. A /24 network has 254 usable hosts, not 252
- **Mistake:** my notes said "2 to the power of 8 minus 2 devices (basically 252)".
- **Fix:** 2⁸ = 256 addresses. Minus 2 = **254** usable hosts.
- **Why:** two addresses in every subnet are reserved. One is the *network address* (the first) and one is the *broadcast address* (the last). Devices cannot use them. Wrong numbers in a subnetting answer are a common interview mistake.

### 2. `gpupdate \force` should be `gpupdate /force`
- **Mistake:** I typed a backslash.
- **Fix:** Windows command options start with a **forward slash** (`/`).
- **Why:** `\` is used in file paths (like `C:\Users`). With the wrong slash, the command will not do what you expect. `gpupdate /force` makes the PC download Group Policy right now instead of waiting about 90 minutes.

### 3. A manually mapped drive can be persistent
- **Mistake:** my notes said manual drive mapping is always temporary.
- **Fix:** it is persistent **if "Reconnect at sign-in" is ticked**. If it is not ticked, the drive disappears after a restart.
- **Why:** this is a common help-desk question: "my mapped drive disappeared". The tick box is often the answer.

### 4. The wallpaper should use a UNC path
- **Mistake:** my lab test used a local path (`C:\Users\...\wallpaper.jpg`).
- **Fix:** use a UNC path like `\\SERVER\Shared\wallpaper.jpg`.
- **Why:** a local path only works on the PC where the file is. A UNC path points to the server, so every client PC can find the file. Users also need **Read** permission on that share.

### 5. Account lockout threshold: use 5 to 10 attempts
- **Mistake:** my lab test used 20 attempts, and my notes gave no advice.
- **Fix:** recommend **5 to 10** failed attempts.
- **Why:**
  - *Too low (1 to 3):* normal typing mistakes lock people out, so the help desk gets many tickets. An attacker can also lock other people's accounts on purpose.
  - *Too high (20 or more):* an attacker can guess many passwords before anything stops them.
  - *5 to 10* is the balance.

## Wording corrections

| Where | My notes said | Now says | Why |
|---|---|---|---|
| Mapping | "internet mask" | **subnet mask** | "Subnet mask" is the correct network term. |
| Group Policy | "Add the policy into the Users OU" | **link the GPO to the Users OU** | "Link" is the correct Group Policy term. |
| Drive mapping | "map network driver", "shared driver", "c driver" | **drive** | A *driver* is software for hardware. A *drive* is a storage location. |
| FSRM | "Frreater" / "Freater" | **Feature** | Spelling. |

## Spelling corrections

| My notes | Correct |
|---|---|
| managment | management |
| Conficurations | Configurations |
| Configuation | Configuration |
| Lunch (the application) | Launch |
| informations | information |
| fist | first |
| adresse / adresses | address / addresses |
| organizational Unit | Organizational Unit |

## Things I added to help the reader

- Domain account policies (password and lockout) only work when the GPO is **linked at the domain level**.
- A table comparing manual mapping with GPO mapping.
- A key-terms table (AD DS, DC, GPO, GPMC, OU, FSRM).

## What I still need to check or complete

- The DNS section is **to be completed**.
- Some screenshots are still missing (see the checklist in the README).
- The lab used a lockout threshold of 20. Retake that screenshot with 5 to 10 if I change it.
- Some GPO names in my screenshots have typos ("Controll Panel No Access"). I can rename them in the lab and retake the screenshots.

## Screenshots to retake

I checked every screenshot. No passwords, tokens or IP addresses appear in them. These ones should be retaken or fixed before publishing:

| Screenshot | Problem | What to do |
|---|---|---|
| `10-gpo-wallpaper.png` | The path shows a personal username (`C:\Users\<USERNAME>\...`). It also uses a local path. | Retake with the UNC path `\\SERVER\Shared\wallpaper.jpg` (use the real server name). |
| `08-gpo-account-lockout.png` | The threshold is 20. The GPO name has a typo ("brout force attack prevent"). | Rename the GPO (for example "Brute Force Attack Prevention"), set the threshold to 5 to 10, and retake. |
| `11-gpo-control-panel-policy.png` | The GPO name has a typo ("Controll Panel No Access"). | Rename the GPO to "Control Panel No Access" and retake. |
| `07`, `08`, `10` | These show the server name `DCHOST`, while the other screenshots show `WIN-35PVS4D3077`. | Retake under one server name, or add a note that the server was renamed. |
| `09-gpo-drive-map.png` | "Reconnect" is not ticked. | Optional: tick it and retake. |

### Files to keep out of the portfolio

`screenshots/image-2.png` and `screenshots/image-3.png` come from an earlier attempt. They show a personal username and a different server name (`DCHOST`). They are not used in the README. Decide whether to delete them (I will not delete anything without asking).
