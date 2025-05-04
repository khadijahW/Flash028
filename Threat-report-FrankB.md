
  $${{\color{BlueViolet}\huge{\textsf{Threat Hunt Report\ }}}}\$$

---
${{\color{Blue}\huge{\textsf{Executive Summary\ }}}}\$

---
At approximately 4:50 PM EST on April 27, 2025, a user reported the appearance of unexpected files on their VM desktop, including what appears to be a ransomware note and several encrypted files. The user did not recognize these files.

An investigation revealed:
- A successful `root` login to the affected VM (`frankb-vm`) at 11:47:24 AM from internal IP address `10.0.0.8`
- The same IP also accessed several other virtual machines in the environment
- Suspicious files such as `/usr/sbin/try-from` and renamed binaries like `safe_finger` appeared during the session, suggesting possible privilege escalation and lateral movement

${{\color{Blue}\large{\textsf{Key Indicators of Compromise (IOCs)\ }}}}\$

---
- `dpkg` command executed by `root` to install legacy network services (`telnetd`, `tcpd`, etc.)
- `/usr/sbin/try-from` and `/usr/sbin/safe_finger` appeared during session (suspicious binaries)
- Privileged access from `10.0.0.8` across multiple VMs


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

- Running the same query but for the actiontype "LogonSuccess" revealed successful logon April 27,2025 at 11:47:24 AM for the root account 
- the remote Ip address is 10.0.0.8 (private)
- This ip address interacted with vm's
  - kc-final-lab
  - edr-machine
  - judewindowsvm
  - frankb-vm
  - th-oscar-p
  - togglevm
  - jj-vm-to-mde
  - vuln-vm-windows
  - vm-final-lab-ke
  - vm-mde-test-cj
  - lisette-final-l
  - winserver2019-a
  - vm-final-lab-vl
  - vm-final-lab-br
  - er-winserver
  - kc-final-server
  - windows-vm
  - jeff-win10-vm
  - vm-final-lab-so
