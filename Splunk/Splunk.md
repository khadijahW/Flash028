# ⚙️ Splunk + Atomic Red Team Lab Setup

This guide walks you through setting up a lab environment using **Splunk**, **Sysmon**, and **Atomic Red Team** for detection engineering, MITRE ATT&CK mapping, and dashboarding.

---

## 🔧 Level 1: Setup and Installation

### 🧩 Step 1: Install Splunk (Free Version)

- Download Splunk Enterprise: [https://www.splunk.com](https://www.splunk.com)  
- Install on Windows Server 2016 or a Linux VM (Linux preferred for scalability).  
- Use default install options.  
- Access via: `https://localhost:8000`  

**Login Credentials**  
---
### 🔩 Step 2: Install Splunk Universal Forwarder on Windows Server 2016

- Purpose: Forward logs to Splunk.
- Download: [Universal Forwarder](https://www.splunk.com/en_us/download/universal-forwarder.html)
- During setup:
  - Select **"Forward Windows Event Logs"**
  - Point to **Splunk Server IP** on **port 9997**
- Ensure port `9997` is open on Splunk server (check firewall).

---

### 🔐 Step 3: Enable PowerShell Logging

Required for Atomic Red Team visibility.

Enable:

- Module Logging
- Script Block Logging
- Event ID 4104

This can be done in gpedit.msc
- Computer Management > Adminstrative Templates > Windows Component > Windows PowerShell
  - Turn on Module Logging : Enabled
  - Turn on PowerShell Script Block Logging : Enabled

### 🔐 Step 4: Installing Atomic Red Team
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
```
- This command is to use TLS 1.2
```
IEX (IWR 'https://raw.githubusercontent.com/redcanaryco/invoke-atomicredteam/master/install-atomicredteam.ps1' -UseBasicParsing);
Install-AtomicRedTeam
```
