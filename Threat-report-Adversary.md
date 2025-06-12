
  $${{\color{BlueViolet}\huge{\textsf{Threat Hunt Report\ }}}}\$$

---
${{\color{Blue}\huge{\textsf{Deep Access:The Adversary\ }}}}\$

---
Scenario
FOr weeks, multiple partner organizations across SOutheast Asia and Eastern Europe detected odd outbound activity to obscure cloud endpoints.Initially dismissed as harmless automation,the anomalies began aligning.
 

${{\color{Blue}\large{\textsf{Key Indicators of Compromise (IOCs)\ }}}}\$

---


## Timeline of Events

| Time (EST) | Event |
|------------|-------|
| 11:47:24 AM | Successful root login to `frankb-vm` |
| 11:48:34 AM | `dpkg` command used to install multiple packages |
| 4:50 PM | User reports suspicious files and ransomware note |

```
DeviceEvents
| where AccountDomain == "FrankB-VM"
```
${{\color{RoyalPurple}\Large {\textsf{Result}}}}\$

Running the query above allowed me to get the full devicename
- frankb-vm.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net
---
Using this I went to the logon events table by running
```
DeviceLogonEvents
| where DeviceName == "frankb-vm.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "LogonFailed"

```
${{\color{RoyalPurple}\Large {\textsf{ Result}}}}\$

<div align="center">
  <img src= "https://github.com/user-attachments/assets/fc7bd506-dfb8-4bc0-8771-7c6b1a8a4ac3" width="5000">
</div>
