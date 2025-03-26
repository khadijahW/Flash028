$${{\color{Goldenrod}\Huge{\textsf{  Threat \ Hunting \ Report\ \}}}}\$$


## Summary
A report from Microsot Azure indicated that there was a violation of the Acceptable ue policy
Activity Summary 
- Date: 3/18/2025 6:40:40 AM
- Description: External reports of Brute Force traffic from you resource where recieved
- Reported Source: 20.81.228.191




# LOGON EVENTS
Query Used
```
DeviceInfo
| where PublicIP == "20.81.228.191"
```
Findings: Device name was identified as "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"


- **MITRE ATT&CK References:**
- T1592 Gathering Victim Host information
- This indicates that the default passwords for vm's was compromised 

Query Used
```
DeviceLogonEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "LogonFailed"
| summarize count()by ActionType, FailureReason, DeviceName
```
Findings: Device had 308 failed logon attempts indicateing evidence of brute force attempt


# NETWORK ACTIVITY


Query Used
```
DeviceNetworkEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
|summarize count()by RemoteIP
```
Findings
| IP Address        | Count |
|------------------|-------|
| 168.63.129.16   | 9     |
| 169.254.169.254 | 25    |
| 8.219.145.111   | 1     |
| 172.66.0.26     | 6     |
| 162.159.140.26  | 6     |
| 172.202.64.10   | 10    |
| 172.202.65.10   | 9     |
| 127.0.0.53      | 8     |
| 0.0.0.0         | 1     |
| 20.60.180.65    | 1     |
| 196.251.73.38   | 3     |
| 10.0.0.0        | 1     |



Query Used
```
DeviceNetworkEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
|summarize totalcount =count()
```
Findings: Total count of 184782
- the device attempted to connect to various ip addresses that 184782 times.

#FILE EVENTS

Query Used
```
DeviceFileEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "FileCreated"
| summarize count() by ActionType
```
Findings: There were a total of 592 Files created


Query Used
```
DeviceFileEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "FileDeleted" 
| summarize count()by ActionType
```
Findings: There was a total of 7025 deleted files

# Process Events

Query Used
```
DeviceProcessEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ProcessCommandLine contains "bash"
| project InitiatingProcessCommandLine
```
Output
- /bin/sh -c "/var/tmp/.update-logs/./History >/dev/null 2>&1 & disown
- /bin/bash /var/tmp/.update-logs/./.b

Findings: 
- this command .update-logs is an attempt to remain stealth
- dev/null - is used to prevent logging







## Analysis
Summarize the analysis conducted, including any patterns or anomalies detected.

## Conclusion
Summarize the overall findings, potential impact, and next steps or recommendations.



