# HELP-19: Wi-Fi is very slow in meeting room 3

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-19 |
| Reporter | Anja Roth |
| Request type | Network problem |
| Priority | P3 |
| Date resolved | `<date>` |

## Summary

In meeting room 3 the Wi-Fi is very slow and video calls freeze. Other rooms work well. It happens every day around 10:00 when the room is full.

## Troubleshooting steps

1. **Find the pattern.** It happens in one room at a busy time, so suspect too many devices on one access point, or interference.
2. **Check the access point (AP) for the room.** In the controller, look at the number of connected devices, the channel and the signal strength around 10:00.
3. **Test it.** Run a speed test and a ping test in the room when it is empty, and again when it is full.
4. **Check the channel and band.** Neighbouring access points on the same channel cause interference. Many devices on the 2.4 GHz band are slow.
5. **Check the coverage.** Is the AP in or near the room? Walls or a closed door can weaken the signal.
6. **Check what uses the bandwidth.** Large downloads or updates at 10:00 may fill the connection.

## Root cause

*Assumed for this scenario:* a single access point on a crowded channel served about 30 devices at once, and many devices used the slower 2.4 GHz band.

## Resolution

1. Move the access point to a less crowded channel, and turn on 5 GHz preference (band steering).
2. If it is still slow at peak time, add a second access point in or near the room.
3. Test the room at 10:00 with a full meeting and a video call.
4. Ask the reporter to confirm over the next few days.

## Prevention

- Do a Wi-Fi coverage check for rooms with many people, and plan enough access points for the number of devices.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P3: respond 8h, resolve 3 days) met? `<yes / no, and why>`

## KB link

- [Check your network connection](../kb-articles/check-your-network-connection.md)
