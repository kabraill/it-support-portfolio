# HELP-20: Lost access to verification codes after getting a new phone

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-20 |
| Reporter | Michael Lange |
| Request type | Password reset |
| Priority | P3 |
| Date resolved | `<date>` |

## Summary

A user got a new phone, and the old one was reset. They can no longer receive verification codes and cannot sign in to their Microsoft 365 account.

## Troubleshooting steps

1. **Confirm the identity of the user.** Do not trust the ticket alone, because an attacker could ask for a reset too. Check by a second route: call the user's known work number, or ask the manager to confirm.
2. **Check the account.** Is it enabled? Which sign-in methods are registered (authenticator app, phone number)?
3. **Check for other methods.** Can the user use a second method, such as an SMS to a registered number, or backup codes?
4. **Check the old device.** Was the app backed up? If not, it must be set up again.

## Root cause

The authenticator app was only on the old phone, which was reset. The user had no second sign-in method and no backup codes.

## Resolution

1. After the identity check, an admin resets the user's multi-factor authentication registration, so that the user can register a new method at the next sign-in.
2. The user signs in and sets up the authenticator app on the new phone.
3. Add a second method (for example a phone number) and show the user how to save backup codes.
4. Confirm that the user can sign in and read email, then close the ticket.

## Prevention

- Ask users to register two methods, and to move the authenticator app to the new phone before resetting the old one.
- Document the identity check for MFA resets.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P3: respond 8h, resolve 3 days) met? `<yes / no, and why>`

## KB link

- [Reset or change your password](../kb-articles/reset-your-password.md)
