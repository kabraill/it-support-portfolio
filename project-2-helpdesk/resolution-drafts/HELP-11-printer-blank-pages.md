# HELP-11: Printer on the first floor prints blank pages

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-11 |
| Reporter | Julia Hartmann |
| Request type | Hardware |
| Priority | P3 |
| Date resolved | `<date>` |

## Summary

The shared printer by the kitchen on the first floor prints blank pages for everyone. The display shows no error. The user tried two different documents.

## Troubleshooting steps

1. **Rule out the documents.** Blank pages for two documents and for several users point to the printer, not the files.
2. **Print a test page from the printer itself** (menu → reports → configuration page). If this is blank too, the problem is in the printer. If it prints correctly, the problem is in the driver or the print job.
3. **Check consumables.** Look at toner or ink levels, and at the drum or imaging unit. A toner cartridge may show "full" if it is empty, or it may be wrongly seated.
4. **Check the cartridge.** Remove it, remove any orange protective strip or tape, shake it gently and put it back.
5. **If the test page works:** clear the print queue, restart the print spooler, and check the driver on one PC.

## Root cause

*Assumed for this scenario:* the toner cartridge was empty, and the toner level sensor did not warn the user.

## Resolution

1. Replace the toner cartridge with a new one and print a test page from the printer.
2. Print a document from one user's PC to check the full path.
3. Ask the reporter to confirm that pages print normally.
4. Order a spare cartridge and note the printer in the supplies list.

## Prevention

- Keep a spare cartridge for each printer model.
- Enable low-toner email alerts on the printer.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P3: respond 8h, resolve 3 days) met? `<yes / no, and why>`

## KB link

- No article yet: needs a new one ("Printer prints blank pages")
