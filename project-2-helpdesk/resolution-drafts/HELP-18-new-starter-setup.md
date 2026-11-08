# HELP-18: New starter: account and laptop needed for next Monday

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-18 |
| Reporter | Thomas Vogel |
| Request type | Access request |
| Priority | P3 |
| Date resolved | `<date>` |

## Summary

A new employee (Sarah Winter, Accounting) starts next Monday. She needs a laptop, a user account, an email address, and access to the Shared folder, all ready before 08:30 on her first day.

## Troubleshooting steps

This is a request, so the steps are the onboarding checklist.

1. **Confirm the details with the manager:** start date, department, job title, which folders and applications she needs, and who approves the access.
2. **Prepare the laptop:** install Windows, join it to the domain, install the standard software, and apply updates. Add it to the asset list.
3. **Create the user account** in Active Directory in the right OU (for example `USA/Users`), following the naming rule. Add her to the right groups, for example Accounting and Domain Users.
4. **Create the mailbox** and add her to the standard mailing lists.
5. **Set up the access** to the Shared folder through the group (not by adding single permissions).
6. **Set up multi-factor authentication** for her account.
7. **Prepare the first sign-in.** Set a one-time password and force a password change at the first logon. Send the temporary password to the manager through a safe channel, never in the ticket or by plain email.

## Root cause

Not applicable (access request for a new employee).

## Resolution

1. Complete the checklist above before Friday afternoon.
2. Test the account on the laptop: sign in, open email, open the Shared folder.
3. Hand over the laptop and the sign-in details on Monday at 08:30, and explain the password rules and how to contact the help desk.
4. Ask the manager to confirm that everything works, and close the ticket.

## Prevention

- Keep a written onboarding checklist and an onboarding request form, so all the details arrive at once and in good time.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P3: respond 8h, resolve 3 days) met? `<yes / no, and why>`

## KB link

- [Reset or change your password](../kb-articles/reset-your-password.md)
- [Connect a network drive](../kb-articles/connect-a-network-drive.md)
