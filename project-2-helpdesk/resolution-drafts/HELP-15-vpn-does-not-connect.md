# HELP-15: VPN does not connect from home

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-15 |
| Reporter | Eva Zimmermann |
| Request type | Network problem |
| Priority | P2 |
| Date resolved | `<date>` |

## Summary

A user working from home cannot connect to the VPN. The client shows "Connection failed" after about 30 seconds. The home internet works and websites open.

## Troubleshooting steps

1. **Confirm the basics.** Is the internet really working? Can the user open several websites? Is the user on Wi-Fi or a cable?
2. **Check the credentials.** Has the password expired, or is the account locked? Check the account in Active Directory.
3. **Check the second factor.** Does the user receive the code? Is the time and date on the PC correct?
4. **Check the VPN client.** Is it up to date? Is it the right profile and server address?
5. **Check the network.** Some home routers and networks block VPN ports. Try a mobile hotspot to see if the VPN connects from another network.
6. **Check the server side.** Is the VPN gateway up? Do other users have the same problem? Look at its log for this user.

## Root cause

*Assumed for this scenario:* the user's domain password had expired two days earlier. The VPN client showed only a generic "Connection failed" message.

## Resolution

1. Reset the password so that the user can choose a new one, and tell the user the rules for a good password.
2. Ask the user to sign in on the PC, then connect to the VPN again.
3. Confirm that the VPN is connected and that the user can open the shared folder.
4. Close the ticket after the user confirms.

## Prevention

- Send password-expiry reminders earlier.
- Explain in the VPN article what the generic error can mean.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P2: respond 4h, resolve 8h) met? `<yes / no, and why>`

## KB link

- [Reset or change your password](../kb-articles/reset-your-password.md)
