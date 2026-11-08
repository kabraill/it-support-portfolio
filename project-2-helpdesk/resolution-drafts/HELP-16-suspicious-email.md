# HELP-16: Suspicious email asking me to confirm my password

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-16 |
| Reporter | Stefan Neumann |
| Request type | Software |
| Priority | P2 |
| Date resolved | `<date>` |

## Summary

A user received an email from "IT Support" with a link asking them to confirm their password within 24 hours. The sender address looks unusual. The user did not click the link and did not enter anything. This is a possible phishing attack, so it is a P2.

## Troubleshooting steps

1. **Confirm what the user did.** The user did not click or enter anything. Ask again, and ask whether anyone else received it.
2. **Check the email safely.** Do not click the link. Look at the full sender address and the message headers. The sender domain does not belong to the company.
3. **Check the link without opening it.** Hover over it to see the real address, and check it with a URL reputation tool if the company allows it.
4. **Check who else got it.** Search the mail system for the same sender or subject.
5. **Check for compromise.** Because nothing was entered, no password reset is needed. If it had been entered, reset the password and check the sign-in logs.

## Root cause

A phishing email from an external sender, pretending to be IT Support and using a time limit to create pressure.

## Resolution

1. Tell the user they did the right thing by not clicking and by reporting it.
2. Block the sender and the link's domain in the mail filter, and remove the email from all mailboxes that received it.
3. Warn the staff with a short message about this email, and remind them that IT never asks for passwords by email.
4. Keep a copy of the email headers with the ticket for the record.
5. Send the user the phishing article.

## Prevention

- Run regular phishing awareness training.
- Turn on multi-factor authentication for all accounts, so a stolen password alone is not enough.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P2: respond 4h, resolve 8h) met? `<yes / no, and why>`

## KB link

- [What to do with a phishing email](../kb-articles/what-to-do-with-a-phishing-email.md)
