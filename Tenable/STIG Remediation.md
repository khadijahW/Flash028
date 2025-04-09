![image](https://github.com/user-attachments/assets/ffc577ce-8692-4ea7-b633-f0da774c46ce)

# 🛡️ STIG Remediation Documentation

This repository documents remediations for STIG (Security Technical Implementation Guide) findings across multiple systems. Use this as a reference for securing systems in alignment with DISA STIG guidelines.

---

## Table of Contents

- [✅ Systems Covered](#systems-covered)
- [🔒 WN10-AU-000035](#wn10-au-000035)
---

## Systems Covered

| System              | STIG Version | Last Updated |
|---------------------|--------------|--------------|
| Windows Server 2016 | v2r6         | Apr 2025     |
---



## WN10-AU-000035 
The system must be configured to audit Account Management - User Account Management failures.

- **Severity:** High
- **Description:** The system must be configured to audit Account Management - User Account Management failures.
- Solution:Configure the policy value for Computer Configuration >> Windows Settings >> Security Settings >> Advanced Audit Policy Configuration >> System Audit Policies >> Account Management >> 'Audit User Account Management' with 'Failure' selected.
- **Fix Text**
1.Configure the system to audit failures for User Account Management.
  Using Group Policy:
  Open gpedit.msc
  Navigate to:
  Computer Configuration > Windows Settings > Security Settings > Advanced Audit Policy Configuration > Audit Policies > Account Management
  Double-click User Account Management
  Check Configure the following audit events > Failure
  Click Apply and OK
  
# PowerShell Remediation
AuditPol /set /subcategory:"User Account Management" /failure:enable
---

## WN10-AU-000500
The Application event log size must be configured to 32768 KB or greater.

- **Severity:** High
- **Description:**The Application event log size must be configured to 32768 KB or greater.
- Solution:If the system is configured to send audit records directly to an audit server, this is NA. This must be documented with the ISSO. Configure the policy value for Computer Configuration >> Administrative Templates >> Windows Components >> Event Log Service >> Application >> 'Specify the maximum log file size (KB)' to 'Enabled' with a 'Maximum Log Size (KB)' of '32768' or greater.
- **Fix Text**
1.Configure the policy value for Computer Configuration
  Administrative Templates Windows Components >> Event Log Service >> Application >> 'Specify the maximum log file size (KB)' to 'Enabled' with a 'Maximum Log Size (KB)' of '32768' or greater.
  
# PowerShell Remediation
AuditPol /set /subcategory:"User Account Management" /failure:enable
---
