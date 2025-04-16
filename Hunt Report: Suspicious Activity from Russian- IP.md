$${{\color{RoyalPurple}\Huge{\textsf{  Hunt \ Report\- Suspicious\ Activity \ from Russian-Origin\ IP \}}}}\$$


$${{\color{Silver}\large{\textsf{Executive Summary\ }}}}\$$ <br>
---
During Scenario 1: Virtual Machine Brute Force Detection, a review of recent logs revealed potentially suspicious activity. Specifically, two successful logon events were observed on the host vm-final-lab-je from the external IP address 5.182.5.119, which may indicate unauthorized access following a brute-force attempt.
The activity was identified using the following query:
```
DeviceLogonEvents
| where RemoteIP in ("85.215.149.156", "92.53.90.104", "5.182.5.119", "185.137.233.87")
| where ActionType != "LogonFailed"
```
$${{\color{RoyalPurple}\Huge{\textsf{ Timeline\ of \ Events}}}}\$$
- April 12th - present
- Account name used: Guest 
Based on the ip address, I used ipinfo.io to determine information about the attack 

<div align="center">
  <img src="https://github.com/user-attachments/assets/689c360d-3ea0-4f43-bf04-865766a3dd4c" width="500">
</div>

Additionaly I utilized Virus total in which Fortinet flagged the ip address as suspicious and a criminal ip.
This IP address has been reported for suspicious activities, including brute-force attacks and unauthorized access attempts.

<div align="center">
  <img src= "https://github.com/user-attachments/assets/acef815a-89d9-462e-bed3-a5a69c5dddb3" width="500">
</div>

- It appears that the remote ip also accessed machines as there were a total of 5 items resulting from the above query.
  - Juliette-finall
  - vm-final-lab-km
  - vm-final-lab-cy
  - vm-final-lab-je
  - vm-final-lab-12

 I then proceeded to check the Network Events using the following query:
 ```
DeviceNetworkEvents
| where RemoteIP contains "5.182.5.119" 
| distinct DeviceName, RemoteIP, ActionType, LocalPort
```
- There were a total of 287 Inbound Connection Attempts made from this IP address but only 5 demonstated successful logon attempts.


