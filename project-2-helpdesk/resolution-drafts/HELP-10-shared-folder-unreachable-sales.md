# HELP-10: Shared folder not reachable for the whole Sales team

> **DRAFT for review.** This is a model answer for a fictional ticket, written to study from. Review it, change it to match what you would really do, and add your own time before you use it as your resolution note.

| Field | Value |
|---|---|
| Ticket ID | HELP-10 |
| Reporter | Markus Braun |
| Request type | Network problem |
| Priority | P1 |
| Date resolved | `<date>` |

## Summary

Nobody in Sales can open the Shared folder. They see "Windows cannot access the shared folder". All offer documents are in it, and there is a deadline at 15:00. It affects a whole team and blocks urgent work, so it is a P1.

## Troubleshooting steps

1. **Confirm the scope.** Is it only Sales, or everybody? Can anyone open it by IP address (`\\<SERVER_IP>\Shared`) instead of the name?
2. **Test the server.** `ping <SERVER_IP>` and `ping <SERVER_NAME>`. If the IP works and the name does not, it is a DNS problem. If neither works, the server or the network is down.
3. **On the server:** check it is running and has no disk errors. Check that the **Server** service (LanmanServer) is running and the share still exists in **Shared Folders**.
4. **Check space and quotas.** Look at free disk space and the FSRM quota on the share.
5. **Check permissions.** Has the Sales group lost access (for example after a group change)?
6. **Check recent changes.** Windows updates, restarts or policy changes since yesterday.

## Root cause

*Assumed for this scenario:* the file server restarted after an update, and the **Server** service did not start again, so the share was not offered to the network.

## Resolution

1. Start the **Server** service on the file server, and set it to start automatically.
2. Confirm that the share is listed and that a Sales user can open it, with the files visible.
3. Tell Markus and the Sales team, and ask them to confirm they can work again.

## Prevention

- Add a service monitor on the file server with an alert if the share stops.
- Schedule updates and restarts outside working hours, and check services afterwards.

## Time spent

| Part | Time |
|---|---|
| Investigation | `<minutes>` |
| Fix | `<minutes>` |
| Total | `<minutes>` |

SLA (P1: respond 1h, resolve 4h) met? `<yes / no, and why>`

## KB link

- [Connect a network drive](../kb-articles/connect-a-network-drive.md)
