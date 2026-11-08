# HELP-12: Laptop does not turn on

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-12 |
| Reporter | Daniel Richter |
| Request type | Hardware |
| Priority | P2 |
| Date resolved | `<date>` |

## Summary

A laptop (asset tag FG-LT-0142) shows a black screen when the power button is pressed. A small light blinks a few times and then stops. It worked normally yesterday evening. One user cannot work, so it is a P2.

## Troubleshooting steps

1. **Check the power.** Is the charger plugged in at the wall and in the laptop? Is the charger light on? Try a different wall socket.
2. **Try a different charger** of the same model, if one is available.
3. **Do a hard reset.** Unplug the charger, remove the battery if it is removable, hold the power button for 30 seconds, then reconnect the charger and try again.
4. **Read the blink pattern.** Many manufacturers use blink counts as error codes (power, memory, display). Look up the pattern for this model.
5. **Rule out the screen.** Connect an external monitor. If the laptop starts and shows an image, the screen is the problem.
6. **Check for signs of damage** such as a liquid spill, a bent charger port, or a swollen battery.

## Root cause

*Assumed for this scenario:* a failed charger. With a working charger, the laptop started normally. The blinking light came from the battery being too low to start.

## Resolution

1. Replace the charger with a new one, and recycle the faulty one.
2. Let the laptop charge and confirm that it starts and signs in.
3. Ask the user to confirm that everything works, and update the asset record.

**If the laptop had been dead:** hand over a loaner laptop, and try to recover the data from the disk before repair.

## Prevention

- Keep a few spare chargers.
- Tell users to report a damaged charger cable early.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P2: respond 4h, resolve 8h) met? `<yes / no, and why>`

## KB link

- No article yet: needs a new one ("My laptop does not start")
