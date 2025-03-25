# Lab Documentation - [Lab Name]

## **1. Lab Overview**
**Objective:**  
[Describe the goal of the lab, e.g., setting up Windows Server 2022, configuring IIS, deploying VMware, etc.]

**Technologies Used:**  
- [List relevant tools, e.g., Windows Server, VMware, F5 Load Balancer, etc.]
- [Additional components, e.g., PowerShell, Python, etc.]

---

## LAB 2: Setting Up WSUS
- Setting up WSUS
- create a GPO for WSUS
  -right click the gpo
  - got to policies -> adminstrative templates -> windows component -> windows update 
  - Specify Intranet Mcirosoft update service ( to allow for clients to reach out to the WSUS services)
 
 once the gpo is applied to the domain or ou
 - run gpupdate so it gets applied to the entire domain


##LAB 3: Recovering a Deleted Active Directory Opject 
- Open Active Directory Administrative Center (ADAC).
  - Enabling of Recycle Bin can be found on the righ pane 
- Navigate to the Deleted Objects container in the left pane.
- Right-click the object you want to restore and select Restore.
