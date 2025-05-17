## Scenario:
At Acme Corp, the eccentric yet brilliant IT admin, Bubba Rockerfeatherman III, isn’t just patching servers and resetting passwords — he’s the secret guardian of trillions in digital assets. Hidden deep within encrypted vaults lie private keys, sensitive data, and intellectual gold... all protected by his privileged account.

But the shadows have stirred.
A covert APT group known only as The Phantom Hackers 👤 has set their sights on Bubba. Masters of deception, they weave social engineering, fileless malware, and stealthy persistence into a multi-stage campaign designed to steal it all — without ever being seen.

The breach has already begun.
Using phishing, credential theft, and evasive tactics, the attackers have infiltrated Acme’s network. Bubba doesn’t even know he's compromised.
## Mission 
Hunt through Microsoft Defender for Endpoint (MDE) telemetry, analyze signals, query using KQL, and follow the breadcrumbs before the keys to Bubba’s empire vanish forever.

Known Information:
DeviceName: anthony-001
RemoteSessionIP: 192.168.0.110

## Flag 1: Identify the Fake Antivirus Program Name
Objective:
Determine the name of the suspicious or deceptive antivirus program that initiated the security incident.

What to Hunt:
Look for the name of the suspicious file or binary that resembles an antivirus but is responsible for the malicious activity.

Thought:
This step is critical for attribution. Identifying the root artifact allows analysts to formulate a hypothesis and determine the origin of the malicious chain of events.

Hints:
1. Platform we use in our company
2. Program name likely begins with the following letters: A, B, or C
3. Contains

```
DeviceFileEvents
| where DeviceName == "anthony-001"
| where (FileName startswith "A" or FileName startswith "B" or FileName startswith "C") 
    and FileName endswith ".exe"
| distinct FileName
```
From the results returned I concluded that the only possible correct answer based of hint 1 would be BitSentinelCore.exe
- Answer: BitSentinelCore.exe

---

## Flag 2: Malicious File Written Somewhere
Objective:
Confirm that the fake antivirus binary was written to the disk on the host system.

What to Hunt:
Identify the one responsible for dropping the malicious file into the disk.

Thought:
This validates the delivery mechanism of the dropper and supports behavioral indicators of compromise, particularly in directories often used by malware.

Hints:
1. Legit software
2. Microsoft
3. Three
```
DeviceFileEvents
| where FileName == "BitSentinelCore.exe"
| where ActionType in ("FileCreated", "FileModified", "FileWritten")
| project InitiatingProcessFileName
```
Answer: csc.exe

---
## Flag 3: Execution of the Program
Objective:
Verify whether the dropped malicious file was manually executed by the user or attacker.

What to Hunt:
Search for process execution events tied to the suspicious binary.

Thought:
Execution of the file marks the start of the malicious payloads being triggered, indicating user interaction or attacker initiation.

Hint:
1. Bubba clicked the .exe file himself

Answer:BitSentinelCore.exe

---
Flag 4 – Keylogger Artifact Written
Objective:
Identify whether any artifact was dropped that indicates keylogger behavior.

What to Hunt:
Search for any file write events associated with possible keylogging activity.

Thought:
This confirms credential harvesting or surveillance behavior linked to the fake antivirus binary.

Hints:
1. ."a rather efficient way to completing a complex process" 
2. News
