# Setup guide: Jira Service Management help desk

This guide shows how to build a small IT help desk for the fictional company **Firma GmbH** in Jira Service Management (JSM), and how to import the 20 practice tickets from `tickets.csv`.

> **Note:** Atlassian changes its screens often. Menu names below are close to what you will see, but they may differ a little. If a menu has a different name, look for the same idea nearby. Plans and limits also change, so check the free plan on Atlassian's site before you sign up.
>
> **Safety:** use your own email to sign up, but never write passwords or tokens into any file in this project. Use placeholders like `<PASSWORD>`.

## What you will build

| Part | Details |
|---|---|
| Site | A free Jira Service Management site, for example `firma-gmbh-helpdesk` |
| Project | An IT service desk called "Firma GmbH IT Help Desk" (key `HELP`) |
| Request types | Password reset, Access request, Hardware, Software, Network problem |
| Priorities | P1 to P4 |
| SLAs | P1 respond 1h / resolve 4h, P2 4h / 8h, P3 8h / 3 days, P4 1 day / 5 days |
| Data | 20 tickets imported from `tickets.csv` |

## Step 1: Create the free site

1. Open the Atlassian website and look for Jira Service Management and its **Free** plan.
2. Sign up with your email address. Create a strong password and keep it in a password manager (not in these files).
3. Choose a site name, for example `firma-gmbh-helpdesk`. The address becomes `<your-site-name>.atlassian.net`.
4. Open Jira Service Management when the site is ready.

## Step 2: Create the service project

1. Choose **Create project** (or **Projects → Create project**).
2. Pick the **IT service management** template (or the closest "IT help desk" template).
3. Choose a **team-managed** or **company-managed** project. Either works. Company-managed gives you more control over priorities and SLAs. Pick whichever the free plan offers.
4. Name: `Firma GmbH IT Help Desk`. Key: `HELP`.

## Step 3: Set up the request types

Request types are the forms that users pick when they ask for help.

1. Open your project → **Project settings → Request types**.
2. Create (or rename existing ones to) these five:

| Request type | Used for |
|---|---|
| Password reset | Locked or expired accounts, lost verification codes |
| Access request | Shared folders, new accounts, blocked settings, file types |
| Hardware | Laptops, monitors, printers |
| Software | Install requests, application errors, suspicious emails |
| Network problem | No internet, VPN, Wi-Fi, missing network drives, domain join |

3. For each request type, add a short **description** that tells the user when to choose it.
4. Remove or hide unused default request types, so the portal stays clear.

## Step 4: Set up the priorities (P1 to P4)

Jira starts with names such as Highest, High, Medium, Low. You will rename them.

1. Open **Jira settings (gear icon) → Issues → Priorities**. (In some projects you need an admin role.)
2. Rename them like this:

| Old name | New name | Meaning |
|---|---|---|
| Highest | P1 | Critical: many users or a whole service is down |
| High | P2 | High: one user or an important function is blocked |
| Medium | P3 | Normal: work is slowed down, there is a workaround |
| Low | P4 | Low: small request or cosmetic problem |

3. If there is a fifth priority ("Lowest"), you can leave it unused.
4. Check that your project's priority scheme includes P1 to P4.

The importer matches the priority by name, so the names must be exactly `P1`, `P2`, `P3` and `P4`.

## Step 5: Set up the SLAs

An SLA (service level agreement) is a promise about how fast you respond and resolve.

| Priority | Time to first response | Time to resolution |
|---|---|---|
| P1 | 1 hour | 4 hours |
| P2 | 4 hours | 8 hours |
| P3 | 8 hours | 3 days |
| P4 | 1 day | 5 days |

1. Open **Project settings → SLAs**.
2. Use (or create) two SLAs: **Time to first response** and **Time to resolution**.
3. For each SLA, add one **goal** per priority. In the goal's issue filter, write a JQL query such as `priority = P1`, and enter the time from the table. Use the order P1, P2, P3, P4, then a final goal for "all remaining issues".
4. Choose a **calendar**. For a real office, create a work-hours calendar (for example Monday to Friday, 08:00 to 17:00). For a simple lab, a 24/7 calendar is fine. Write which one you used in your README later, because "3 days" and "5 days" behave differently with working hours.
5. Choose the SLA start, pause and stop conditions. The usual choice: the clock starts when the ticket is created, pauses while it is waiting for the customer, and stops when it is resolved (first response stops on the first agent comment).

## Step 6: Import the tickets from `tickets.csv`

1. Make sure the project, request types and priorities from the steps above are ready.
2. Open the CSV file in a text editor once to check it. It has five columns: `Summary`, `Description`, `Request Type`, `Priority`, `Reporter`.
3. Go to **Jira settings → System → External system import → CSV**. (Some plans have **Project settings → Import** instead.)
4. Upload `tickets.csv`. Pick your `HELP` project. Check that the file encoding is **UTF-8** and the delimiter is a **comma**.
5. Map the fields:

| CSV column | Jira field |
|---|---|
| Summary | Summary |
| Description | Description |
| Priority | Priority |
| Request Type | Request Type (if offered), otherwise see the note below |
| Reporter | See the note below |

6. Run the import and open the project's **queue** to see the 20 tickets.

**Request Type note:** the CSV importer cannot always set the customer-facing request type. If it is not offered, import with the issue type **Service Request** and set the request type afterwards, either by editing the tickets one by one or in a **bulk change**. You can also import the type into a **label** and then use a search to find each group.

**Reporter note:** the reporter names in the CSV are fake people. Jira can only use real user accounts as reporters, so the import may reject them or use you instead. Two simple options:

1. Map `Reporter` to a **custom text field** called "Reported by" (create it first in Jira settings → Issues → Custom fields), or
2. Leave `Reporter` unmapped and let yourself be the reporter. The fake name is lost, so add it to the ticket by hand if you need it.

Do not invite fake people by email, and do not use real people's names or addresses.

## Step 7: Check your help desk

Walk through this list:

- [ ] The project has five request types.
- [ ] The priority names are P1 to P4.
- [ ] Each ticket has an SLA timer (open a ticket and look for the SLA panel).
- [ ] You can see 20 tickets in the queue.
- [ ] Take screenshots (for the README later): the request types, the SLA settings, the queue and one open ticket. Hide your email address and any account ID before saving.

## Step 8: Resolve the tickets yourself

1. Pick a ticket and set it to **In progress**.
2. Work on it in your lab where it matches (see below).
3. Write your notes with `ticket-template.md`.
4. Add a short comment in Jira, set the status to **Resolved**, and link the matching article from `kb-articles/`.

**Tickets that match the AD lab:** locked account, missing Z: drive, blocked .jpg upload, shared folder full, 169.254 address, domain join error, Control Panel blocked, expired password. Tickets about the whole floor, the printer, VPN and so on are general help desk practice, so write your best realistic answer from your own knowledge.

## Next

When you have resolved a few tickets, write a `README.md` for this project with your screenshots and a short summary: what you built, how many tickets you resolved, and what you learned.
