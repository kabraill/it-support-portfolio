# HELP-9: No internet for the whole second floor

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-9 |
| Reporter | Karin Schulz |
| Request type | Network problem |
| Priority | P1 |
| Date resolved | `<date>` |

## Summary

About 25 users on the second floor have no internet and cannot use Teams. Wi-Fi shows as connected and the desk phones still work. The problem affects a whole floor, so it is a P1.

## Troubleshooting steps

1. **Confirm the scope.** Ask two users on the second floor, and one user on another floor, to open a website. Result: only the second floor is affected.
2. **Check one affected PC.** `ipconfig /all` shows an IP address, gateway and DNS server. So DHCP works and the PC is on the network.
3. **Test in layers.** `ping <GATEWAY_IP>` works. `ping 8.8.8.8` fails. So the problem is between the floor's network and the internet, not the PC.
4. **Check the network hardware on the floor.** Look at the floor switch: power, uplink port lights, and any error lights. Check the cable that links the switch to the main network.
5. **Check the core.** From the server room, check that the router and the main switch are up, and that other floors still reach the internet.

## Root cause

*Assumed for this scenario:* the uplink between the second-floor switch and the core switch failed, either a loose or damaged cable, or a port that stopped working. The switch itself still had power, so local traffic and phones kept working.

## Resolution

1. Reseat the uplink cable at both ends. If the link light stays off, replace the cable or use a spare port.
2. Confirm the uplink light is on and users on the second floor can open websites and Teams.
3. Tell the reporter and the affected users that service is back.
4. Record the outage time for the SLA.

## Prevention

- Monitor switch uplinks and send an alert when one goes down.
- Keep a spare patch cable and a labelled uplink for each floor.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P1: respond 1h, resolve 4h) met? `<yes / no, and why>`

## KB link

- [Check your network connection](../kb-articles/check-your-network-connection.md)
