# ⚙️ Splunk + Atomic Red Team Lab Setup

<p align="center">
  <img src="https://github.com/user-attachments/assets/dc4a9264-efd2-490d-bc3e-812a8152988c" width="400px" />
</p>

This guide walks you through setting up a lab environment using **Splunk**, **Sysmon**, and **Atomic Red Team** for detection engineering, MITRE ATT&CK mapping, and dashboarding.

---

## 🔧 Level 1: Setup and Installation

### 🧩 Step 1: Install Splunk (Free Version)

- Download Splunk Enterprise: https://www.splunk.com  
- Install on Windows Server 2016 or a Linux VM (Linux preferred for scalability).  
- Use default install options.  
- Access via: `https://localhost:8000`  

---

### 🔩 Step 2: Install Splunk Universal Forwarder on Windows Server 2016

- Purpose: Forward logs to Splunk.
- Download: https://www.splunk.com/en_us/download/universal-forwarder.html
- During setup:
  - Select "Forward Windows Event Logs"
  - Point to Splunk Server IP on port 9997
- Ensure port 9997 is open on Splunk server (check firewall).

---

### 🔐 Step 3: Enable PowerShell Logging

Required for Atomic Red Team visibility.

Enable:

- Module Logging
- Script Block Logging
- Event ID 4104

This can be done in gpedit.msc

Navigate to:

Computer Configuration > Administrative Templates > Windows Components > Windows PowerShell

Turn on the following:

- Turn on Module Logging : Enabled  
- Turn on PowerShell Script Block Logging : Enabled

---

### 🔐 Step 4: Installing Atomic Red Team

Reference: https://github.com/redcanaryco/invoke-atomicredteam/wiki/Installing-Invoke-AtomicRedTeam

Run the following commands in PowerShell as administrator:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```

```
IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing);
Install-AtomicRedTeam
```
```
IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicsfolder.ps1' -UseBasicParsing); Install-AtomicsFolder
```
---

### 🔐 Step 5: Installing MITRE ATT&CK App for Splunk

<p align="center">
  <img src="https://github.com/user-attachments/assets/a60b45b4-4e8a-4bf6-8460-f5c22a7d9384" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/94d2bbe7-5e28-46cd-b829-2c7ba4323b39" />
</p>

---

### 🔐 Step 6: Run Atomic Test - T1136.001 (Create Local User)

Run the Atomic Red Team test for: T1136.001 - Creating a local user

<p align="center">
  <img src="https://github.com/user-attachments/assets/88148c05-2e35-446b-b003-2e05ac3485e1" />
</p>

Once executed, the New-LocalUser action will appear in logs.

<p align="center">
  <img src="https://github.com/user-attachments/assets/6f05fa64-1aaa-4f9e-89aa-860bcbb47fb9" />
</p>

---

### 🔐 Step 7: Finding the ATT&CKs in Splunk

Search query:

index=endpoint New-LocalUser  
| eval mitre_technique_id="T1136.001"  
| eval kill_chain_phase="persistence"  
| table _time, host, CommandLine, User, mitre_technique_id, kill_chain_phase

Save this as a report:

- Add a title
- Schedule it if needed

<p align="center">
  <img src="https://github.com/user-attachments/assets/413111c8-4fe2-43df-9cfb-e3156e60d1e7" />
</p>

