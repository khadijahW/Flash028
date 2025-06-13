
  $${{\color{Orange}\huge{\textsf{Threat Hunt Report: Deep Access:The Adversary\ }}}}\$$

---
$${{\color{Silver}\huge{\textsf{Scenario  }}}}\$$

---
For weeks, multiple partner organizations across Southeast Asia and Eastern Europe detected odd outbound activity to obscure cloud endpoints. Initially dismissed as harmless automation, the anomalies began aligning.

Across sectors — telecom, defense, manufacturing — analysts observed the same patterns: irregular PowerShell bursts, unexplained registry changes, and credential traces mimicking known red-team tools.

Then came a break. A tech firm flagged sensitive project files leaked days before a bid was undercut. An energy provider found zipped payloads posing as sync utilities in public directories.

Whispers grew — not one actor, but a coordinated effort. Code fragments matched across unrelated environments. The beaconing continued: quiet, rhythmic pings to endpoints no business could explain.

Some suspect Starlance — an old, disbanded joint op revived. Others say mercenary crews using supply chain access and familiar tooling.

What’s clear: this wasn’t smash-and-grab. It was long game.

Your task: trace the access, map the spread, and uncover what was touched — or taken. Two machines hold the truth, scattered and shrouded.

No alerts fired. No passwords changed.
But something was here…
…and it might return.

<div align="center">
 <img src =https://github.com/user-attachments/assets/1d94b9fe-bd19-4e9a-b130-5dd7ffb2c4d5 width="500">
</div>
  </br>

${{\color{Orange}\huge{\textsf{Flag - by - Flag Analysis\ }}}}\$
## Starting point
  - Before you officially begin the flags, you must first determine where to start hunting. The attack points are randomized, but you may want to start with the newly created virtual machines that were only active for a few hours before being deleted, implying that the device(s) did not generate thousands of recorded processes, at least not in the central logging repository. 

a. Around May 24th 2025

The hunt begin by determining the device in which attacks were initiated, in which i utilized the timestamp explanding to a day before and a day after.

📌 *Answer:* `Acolyte756`

Query Used
```
DeviceProcessEvents
| where Timestamp between (datetime(2025-05-23 00:00:00) ..datetime(2025-05-25 23:59:59) )
|summarize ProcessCount = count()by DeviceName
| where DeviceName startswith "a"
|order by ProcessCount asc
```
## Flag 1 – Initial PowerShell Execution Detection

*Objective*:
Pinpoint the earliest suspicious PowerShell activity that marks the intruder's possible entry.

*What to Hunt*:
Initial signs of PowerShell being used in a way that deviates from baseline usage.

*Thought*:
Understanding where it all began helps chart every move that follows. Look for PowerShell actions that started the chain.
When was the first PowerShell activity in the system?

${{\color{Orange}\large{\textsf{📌 Answer: 2025-05-25T09:14:02.3908261Z}}}}$

Query Used
```
DeviceProcessEvents
| where DeviceName == "acolyte756"
| where InitiatingProcessFileName == "powershell.exe"
| where FileName has "Powershell.exe"
| project Timestamp, DeviceName, InitiatingProcessFileName, FileName, ProcessCommandLine, AccountName
| order by Timestamp asc
```
## Flag 2 –  Suspicious Outbound Signal
*Objective*
Confirm an unusual outbound communication attempt from a potentially compromised host.

*What to Hunt*:
External destinations unrelated to normal business operations.

*Thought*:
When machines talk out of turn, it could be a sign of control being handed off.

*Hint*: 
1. We don't have a controlled remote server
2. hollow tube
Figure out the unusual outbound connection

${{\color{Orange}\large{\textsf{📌 Answer: eoqsu1hq6e9ulga.m.pipedream.net}}}}$

Query Used
```
DeviceNetworkEvents
| where DeviceName == "acolyte756"
| where RemoteUrl != "" or RemoteIPType == "Public"
| where RemoteUrl !has "microsoft" and RemoteUrl !has "windowsupdate"
| where InitiatingProcessFileName has_any ("powershell.exe", "cmd.exe", "wscript.exe", "curl.exe", "wget.exe")
| project Timestamp, RemoteUrl, RemoteIP, InitiatingProcessFileName, InitiatingProcessCommandLine, Protocol, RemotePort
| order by Timestamp desc
```
## Flag 3 –  Segistry-based Autorun Setup
*Objective*:
Detect whether the adversary used registry-based mechanisms to gain persistence.

*What to Hunt*:
Name of the program tied to the new registry value created.

*Thought*:
Registry is a favored place to hide re-execution logic — it’s reliable, stealthy, and usually overlooked.
Identify the file associated with the newly created registry value

It took me a bit of time to realize that registry value was actually referencing within the Registry value data.
The complete field showed powershell.exe -WindowStyle Hidden -Exec Bypass -File C:\Users\Public\C2.ps1

${{\color{Orange}\large{\textsf{📌 Answer:C2.ps1}}}}$


Query Used
```
DeviceRegistryEvents
| where DeviceName == "acolyte756"
| where InitiatingProcessFileName has_any ("powershell.exe")
| project RegistryValueData, Timestamp, RegistryKey,RegistryValueName,InitiatingProcessFileName,InitiatingProcessCommandLine,InitiatingProcessFolderPath
// timestamp 2025-05-25T09:14:02.7132107Z
```
## Flag 4 –  Scheduled Task Persistence
*Objective*:
Investigate the presence of alternate autorun methods used by the intruder.

*What to Hunt*:
Verify if schedule task creation occurred in the system. 

*Thought*:
Adversaries rarely rely on just one persistence method. Scheduled tasks offer stealth and reliability — track anomalies in their creation times and descriptions.
Identify the earliest registry value tied to the schedule task creation

Based on the though process and flag title to look for scheduled task, I decided to include that in my query when looking for the answer.Based on the previous flag, I noticed after explanding the registry key field that at the end of the value it mentioned SimC2Task. The earliest task occurs at 2025-05-25T09:14:05.0880043Z.

${{\color{Orange}\large{\textsf{📌 Answer:}}}}$ `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\SimC2Task`


Query Used
```
DeviceRegistryEvents
| where DeviceName == "acolyte756"
| where RegistryKey contains "Schedule" // Focus on Task Scheduler registry entries
| project Timestamp, RegistryKey, RegistryValueName, RegistryValueData, InitiatingProcessFileName
| order by Timestamp asc
```
## Flag 5 –  Obfuscated PowerShell Execution
*Objective:*
Uncover signs of script concealment or encoding in command-line activity.

*What to Hunt*:
Look for PowerShell patterns that don't immediately reveal their purpose — decoding may be required.

*Thought*:
Encoding is a cloak. Finding it means someone may be hiding something deeper within an otherwise familiar tool.

*Hint*: 
1. "Simulated obfuscated execution"

${{\color{Orange}\large{\textsf{📌 Answer:}}}}$ `"powershell.exe" -EncodedCommand VwByAGkAdABlAC0ATwB1AHQAcAB1AHQAIAAiAFMAaQBtAHUAbABhAHQAZQBkACAAbwBiAGYAdQBzAGMAYQB0AGUAZAAgAGUAeABlAGMAdQB0AGkAbwBuACIA`


Query Used
```
DeviceProcessEvents
| where DeviceName == "acolyte756"
| where Timestamp between (datetime(2025-05-25 00:00:00) .. datetime(2025-05-25 23:59:59))  // Full day of May 25, 2025
| where InitiatingProcessFileName == "powershell.exe"
| where ProcessCommandLine has_any ("-EncodedCommand", "-Command", "base64")  // Look for encoded PowerShell execution patterns
| project Timestamp, DeviceName, FileName, ProcessCommandLine, AccountName
| order by Timestamp asc

```
## Flag 6 –  Evasion via Legacy Scripting
*Objective:*
Detect usage of outdated script configurations likely intended to bypass modern controls.

*What to Hunt:*
Look for uncommon scripting version of PowerShell or execution flags that reduce oversight.

*Thought:*
Modern defenses expect modern behavior. Watch for forced downgrades or legacy runtime calls.

Provide the command value used to downgrade PowerShell?

${{\color{Orange}\large{\textsf{📌 Answer:"powershell.exe" -Version 2 -NoProfile -ExecutionPolicy Bypass -NoExit}}}}$


Query Used
```
DeviceProcessEvents
| where DeviceName == "acolyte756"
| where InitiatingProcessFileName == "powershell.exe"
| where ProcessCommandLine has_any ("-Version", "2.0", "-ExecutionPolicy Bypass")  // Look for downgrade flags
| project Timestamp, DeviceName, FileName, ProcessCommandLine, AccountName
| order by Timestamp asc
```
## Flag 7 – Remote Movement Discovery
*Objective:*
Reveal the intruder's next target beyond the initial breach point.

*What to Hunt:*
Trace outbound command patterns that reference hostnames unfamiliar to the local machine.

*Thought:*
Lateral movement often hides in plain sight. Connections to the right system at the wrong time can be the giveaway.

What is the name of the next potentially compromised machine?


While searching through the logs for the previous flag, I noticed that a few of the proccess command line displayed another device within their field. The field also showed credentials used to and cmd.exe as the filename indicating that a remote session was initiated from acolyte756 indicating lateral movement.


${{\color{Orange}\large{\textsf{📌 Answer:victor-disa-vm}}}}$


## Flag 8 – Remote
Identify the subtle digital footprints left during a pivot.

*What to Hunt:*
Artifacts with naming patterns that imply staging, sync, or checkpointing.

*Thought:*
Every move leaves a mark — even if that mark is as simple as a filename that doesn't belong.

*Hint:*
1. point
Identify the name of the lateral entry point


${{\color{Orange}\large{\textsf{📌 Answer:}}}}$`savepoint_sync.lnk`

Query Used
```
DeviceFileEvents
| where DeviceName == "victor-disa-vm"  // Replace with the second compromised host
| where FileName has_any ("staging", "checkpoint", "sync", "update", "test", "tmp")  // Look for specific suspicious naming patterns
| where FileName contains "point"
| project Timestamp, DeviceName, FileName, FolderPath, ActionType
| order by Timestamp desc
```
## Flag 8.1 –  Persistence Registration on Entry
*Objective:*
Detect attempts to embed control mechanisms within system configuration.

*What to Hunt:*
Registry values tied to files or commands that were not present days before.

*Thought:*
Nothing says ownership like persistence. Look for traces that don’t match the system’s normal operational cadence.

*Hint:* 
1. Utilize previous findings

Figure out the registry data value associated?

${{\color{Orange}\large{\textsf{📌 Answer:}}}}$`"powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\Users\Public\savepoint_sync.ps1"`

Query Used
```
DeviceRegistryEvents
| where DeviceName == "victor-disa-vm"  // Replace with the compromised host name
| where RegistryKey has_any ("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run", "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\RunOnce", "SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Schedule\\TaskCache")
| where RegistryValueData has_any ("staging", "checkpoint", "sync", "update", "test", "tmp")  // Match file names found in previous query
| project Timestamp, DeviceName, RegistryKey, RegistryValueName, RegistryValueData, InitiatingProcessFileName
| order by Timestamp desc
```
## Flag 9 –  External Communication Re-established
*Objective:*
Verify if outbound signals continued from the newly touched system.

*What to Hunt:*
Remote destinations not associated with the organization’s known assets.

*Thought:*
When one door closes, another beacon opens. Follow the whispers outbound.

*Hint:* 
1. Utilize previous findings

Search for the suspicious outbound connection?

${{\color{Orange}\large{\textsf{📌 Answer:"eo1v1texxlrdq3v.m.pipedream.net1"}}}}$

Query Used
```
DeviceNetworkEvents
| where DeviceName == "victor-disa-vm"
| where RemoteUrl != "" or RemoteIPType == "Public"
| where RemoteUrl !has "microsoft" and RemoteUrl !has "windowsupdate"
| where InitiatingProcessFileName has_any ("powershell.exe", "cmd.exe", "wscript.exe", "curl.exe", "wget.exe")
| order by Timestamp desc
```
