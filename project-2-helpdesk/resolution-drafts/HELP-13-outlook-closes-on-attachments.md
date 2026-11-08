# HELP-13: Outlook closes when I open attachments

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-13 |
| Reporter | Nina Krause |
| Request type | Software |
| Priority | P3 |
| Date resolved | `<date>` |

## Summary

Outlook closes by itself every time the user opens a PDF attachment. Emails without attachments work. It started after the last Windows update.

## Troubleshooting steps

1. **Reproduce it.** Open a PDF attachment on the user's PC. Outlook closes. Try a Word attachment: does it close too?
2. **Check the pattern.** If only PDFs crash it, suspect the PDF viewer, its preview handler or an add-in.
3. **Start Outlook in safe mode** (`outlook.exe /safe`, with the user's permission). Open a PDF attachment. If it works, an add-in is the cause.
4. **Disable add-ins** one by one (File → Options → Add-ins). Check the PDF preview or PDF maker add-ins first.
5. **Check updates.** See if Office and the PDF reader are up to date, and check the Windows update that was installed.
6. **Check the Windows Event Viewer** (Application log) for an Outlook crash entry, which names the faulty module.

## Root cause

*Assumed for this scenario:* the PDF preview handler of the PDF reader was not compatible with the latest Windows update, and it crashed Outlook whenever an attachment was previewed or opened.

## Resolution

1. Update the PDF reader to the latest version, which fixes the handler.
2. If the update is not available, disable the PDF preview add-in in Outlook as a workaround.
3. Open several PDF attachments to confirm that Outlook stays open.
4. Ask the user to confirm and close the ticket.

## Prevention

- Test major Windows updates on a few PCs first.
- Keep Office and the PDF reader up to date through central management.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P3: respond 8h, resolve 3 days) met? `<yes / no, and why>`

## KB link

- No article yet: needs a new one ("Outlook closes unexpectedly")
