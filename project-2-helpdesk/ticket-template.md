# Ticket resolution notes: template

Copy this file for each ticket you resolve. Name the copy after the ticket, for example `resolved/HELP-1-account-locked.md`. Write in plain, short sentences, so that a colleague can follow what you did.

> Do not write real passwords, tokens or personal data in your notes. Use placeholders such as `<PASSWORD>` and `<USERNAME>`.

---

## Ticket

| Field | Value |
|---|---|
| Ticket ID | HELP-`<number>` |
| Reporter | `<name>` |
| Request type | `<Password reset / Access request / Hardware / Software / Network problem>` |
| Priority | `<P1 / P2 / P3 / P4>` |
| Date opened | `<date>` |
| Date resolved | `<date>` |

## Summary

One or two sentences: what was the problem, and who was affected?

## Troubleshooting steps

List what you checked, in order, and what each check showed. Include failed attempts, because they show how you think.

1. `<Step 1: what I checked, and what I saw>`
2. `<Step 2>`
3. `<Step 3>`

Useful tools and commands to mention: `ipconfig /all`, `ping`, `nslookup`, `gpupdate /force`, Active Directory Users and Computers, Group Policy Management, File Server Resource Manager.

## Root cause

What actually caused the problem? Name the setting, the service or the mistake.

## Resolution

What did you change to fix it? Describe the exact steps.

How did you confirm that it works, and did the user confirm it?

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

Was the SLA met? `<yes / no, and why>`

## Prevention (optional)

How can we stop this from happening again? For example a policy change, a user tip or a monitoring alert.

## KB link

Link to the knowledge base article that helps the user or colleagues next time:

- `<kb-articles/file-name.md>`, or "No article yet: needs a new one"
