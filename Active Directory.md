## Active Directory Lab
**Description**
This project aims to simplify the setup and management of Active Directory (AD) environments. It includes scripts, configuration templates, and documentation designed to automate and streamline the deployment, management, and troubleshooting of Active Directory services. 

**Prerequisites**
- Windows Server 2019 or newer.
- PowerShell 5.1 or newer.
- VMWARE or Virtual Box

This guide outlines the detailed steps to set up an Active Directory environment on a Windows Server 2019 instance running in Oracle VM VirtualBox. This setup is crucial for creating a controlled, simulated network environment for testing and development purposes.

**Step 1: Install Windows Server 2019 on VirtualBox**

1. Start with a Virtual Machine: Ensure you have Oracle VM VirtualBox installed on your host machine. Create a new virtual machine (VM) and select "Windows Server 2019" as the operating system.
2. Adjust Network Settings: Configure two network adapters for the VM:
- Adapter 1: Set to NAT. This allows your server to access the internet for updates and software installations.
- Adapter 2: Set to Internal Network, aligning with the topology you're implementing. This facilitates communication within your virtualized network environment.
- 
  <img src= "https://github.com/khadijahW/Flash028/assets/99515087/e89018da-4738-4fbb-8f7e-d1b61ffb59c4" width="500">
**Step 2: Initial VM Configuration**

Insert Guest Additions CD Image: Navigate to Devices > Insert Guest Additions CD Image within the VirtualBox interface to improve interaction between the host and the VM. This step enhances functionalities such as clipboard sharing and window scaling.
Install Guest Additions: Within the VM, open File Explorer and navigate to the CD drive containing the VirtualBox Guest Additions. Run the installer for AMD64 systems. Once the installation completes, shut down the VM to apply changes.

**Step 3: Network Configuration Inside the VM**

Access Network and Sharing Center: Within the VM, go to Control Panel > Network and Internet > Network and Sharing Center > Change adapter settings.
Identify the NAT Adapter: Right-click on the adapter listed as connected to the Internet, go to Status > Details, and note the IP address (it should be in the 10.0.X.X range). Rename this adapter to "Internet" for easier identification.
System Rename: Right-click on the Start button, select System, and rename the computer to "DC". Follow the prompts to restart the computer for the name change to take effect.

**Step 4: Configuring IP Address for the Internal NIC**

Set Static IP for Internal Network Adapter: Navigate back to Network and Sharing Center > Change adapter options. Right-click on the adapter you've designated for the internal network (not the one named "Internet"), and select Properties.
Configure IPv4 Settings: Select Internet Protocol Version 4 (TCP/IPv4) and click Properties. Configure the following settings:
IP address: 172.16.0.1
Subnet mask: 255.255.255.0
Default gateway: Leave this field empty, as we're configuring a static IP for internal network purposes.
Preferred DNS server: 127.0.0.1 (This points back to the DC itself, which will be configured as a DNS server during the Active Directory setup.)

## Adding Roles and Configuring Active Directory Domain Services ##

<img src= "https://github.com/khadijahW/Flash028/assets/99515087/01e499fa-3619-4827-81ee-c8246d55ee20" width="500">

**Step 5: Launch Server Manager**

Open Server Manager: Upon restarting your VM post-renaming, open Server Manager directly from the Start menu or taskbar.

**Step 6: Add Roles and Features**

Initiate the Wizard: 
- In the Server Manager dashboard, find and click on Add roles and features. This launches the Add Roles and Features Wizard, guiding you through the installation process.
- Choose Installation Type: Ensure that the Role-based or feature-based installation option is selected before clicking Next.
- Server Selection: The wizard moves to the Server Selection step. Your current server should be highlighted.
  - Confirm that it is selected, then click Next.
- Add Active Directory Domain Services Role:
In the Roles list, scroll until you find Active Directory Domain Services. Select it.
- A new window pops up, suggesting adding features that are required for Active Directory Domain Services. Click Add Features on this prompt.
  - Proceed by clicking Next. Skip the Features section by leaving everything at defaults and again select Next.
  - Confirmation and Installation: Review your selections. Then, click Install. The installation process begins, and no restart will be required at this point. You can continue to use the server or even close the wizard; the installation will complete in the background.

**Step 7: Configure Active Directory Domain Services**

- Launch AD DS Configuration: Once the role installation completes, a notification flag at the top right corner of the Server Manager dashboard shows a yellow exclamation mark. Click on this flag, and a drop-down menu appears. Select Promote this server to a domain controller.
- Promotion Wizard:
  - Deployment Configuration: Choose Add a new forest since this is the first Domain Controller and you are creating a new domain. Enter your desired domain name in the Root domain name field (e.g., mydomain.com).
  - Domain Controller Options: Follow through the wizard. When prompted, provide a Directory Services Restore Mode (DSRM) password, which is crucial for restoring the AD DS environment in case of failure.
  - DNS Options and Additional Options: Leave these at their default settings, unless your setup requires specific configurations.
  - Paths: Default locations for the database, log files, and SYSVOL are typically fine for most environments.
  - Review Options and Prerequisites Check: The wizard presents a summary of your choices. Review them and make any necessary adjustments. The wizard then performs a prerequisites check. Ensure there are no critical warnings or errors.
  - Install: With all prerequisites met and configurations reviewed, click Install. The server will automatically reboot after the installation completes, signifying that it's now a Domain Controller within your new mydomain.com forest.

**Step 8: Creating a Dedicated Admin Account**
Access Active Directory Users and Computers

Open Administrative Tools: Click on the Start menu, navigate to the Windows Administrative Tools folder, and select Active Directory Users and Computers. This tool is essential for managing AD objects like users, groups, and organizational units.
Create an Organizational Unit for Admin Accounts

1. Navigate to Your Domain: In the Active Directory Users and Computers window, locate your domain (e.g., mydomain.com) in the left-hand pane.
2. Create a New OU: Right-click on your domain name, select New, and then Organizational Unit. Name this new OU ADMIN or a similar name that clearly identifies its purpose as containing administrative accounts.
- create a New Admin User

## Installing Remote Access and Configuring NAT
**Step 1: Install Remote Access Role**

1. Open Server Manager: Start by launching the Server Manager from your Start menu or taskbar.
2. Add Roles and Features: Click on Manage in the upper-right corner of the Server Manager dashboard, then select Add Roles and Features from the dropdown menu.
3. Before You Begin Page: Click Next on the "Before you begin" page, ensuring you’ve met all prerequisites.
4. Installation Type: Choose Role-based or feature-based installation and click Next.
5. Server Selection: Ensure the current server is selected and click Next.
6. Select Server Roles: In the roles list, find and select Remote Access, then click Next. You might be prompted to add features that are required for Remote Access; accept these by clicking Add Features.
7. Features: Leave the default features selected and click Next.
8. Remote Access Role Services: On the Remote Access page, just click Next. When you reach the Role Services page, select Routing then click Next.
9. Confirmation and Installation: Review your selections and click Install. Wait for the installation process to complete. This process adds the necessary role services to your server, enabling it to manage remote connections and route traffic appropriately.

**Step 2: Configure NAT using Routing and Remote Access**

1. Launch Routing and Remote Access: Post-installation, go back to Server Manager, click on Tools in the top right corner, and select Routing and Remote Access from the dropdown menu.
2. Configure the Server: In the Routing and Remote Access MMC (Microsoft Management Console), right-click on your server (listed by its name) and select Configure and Enable Routing and Remote Access.
3. Setup Wizard: The wizard starts. Click Next on the initial page. On the configuration page, select Network address translation (NAT) to allow your private network clients to access the internet using a single public IP address. Click Next.
4. Public Interface Selection: Choose the interface connected to the internet. This is the interface you previously configured as "Internet" in your VM network settings. Ensure the option Use this interface to connect to the internet is selected. Click Next.
5. Completing the Configuration: Follow through any remaining prompts and finalize the configuration. Once done, your server should now act as a NAT gateway for your clients.
6. Verify Status: In the Routing and Remote Access MMC, your server's icon should appear with a green arrow, indicating that the service is running and configured correctly.

## Setting Up DHCP for Dynamic IP Address Allocation
To ensure your Windows 10 clients can automatically receive IP addresses and successfully access the internet, setting up a DHCP server is essential:

1. Add DHCP Role:
- In Server Manager, click Add roles and features.
- Select DHCP Server, proceed through the wizard, and click Install.
2. Configure DHCP:
- Open DHCP from Tools in Server Manager.
- Right-click your DHCP domain, choose New Scope, and follow the wizard to define the scope, including entering the IP range specified in your lab.
- Set the subnet mask to /24.
- Define the lease duration according to how long a computer can retain its IP address before it is refreshed.
- Choose to configure DHCP options, specifying the DNS server as 172.16.0.1 to align with your network topology.
- Set the domain controller to forward traffic, ensuring clients use the internal NIC as their default gateway. Add this configuration and proceed.
3. Activate and Authorize DHCP:
- Activate the scope and confirm you wish to do so in the wizard.
- After finishing the scope setup, right-click your server in the DHCP console, choose Authorize, and then refresh.
- Your IPv4 icon should turn green, indicating the DHCP server is active and authorized.
- Initially, there might be no leases if client computers have not yet been created or connected.
4. Finalize DHCP Setup:
- Navigate to IPv4 > Server Options, select option 003 Router, and add 172.16.0.1 as the gateway.
- Apply the changes and restart the DHCP service to ensure all configurations are properly implemented.

## Powershel Script
Utilized to automate the process of creating user accounts in Active Directory from a list of names

**Overview of the Script**
1. Environment Setup: You start by setting the execution policy of PowerShell to Unrestricted to allow scripts to run. This step is crucial for environments that default to restricted execution policies, which could prevent the script from running.
2. Script Parameters:
- $PASSWORD_FOR_USERS defines a default password for all users created by this script. It's set to "Password1" in your example, which should ideally be replaced with a more secure password in a real-world scenario.
- $USER_FIRST_LAST_LIST gets the content of a file named names.txt located in the current directory. This file should contain the first and last names of the users you want to create, with each name on a new line.
3. Secure Password Conversion: The plaintext password is converted to a secure string, which is a requirement for setting the account password in Active Directory through PowerShell.
4. Creating an Organizational Unit (OU): The script creates a new OU named _USERS where all the user accounts will be placed. The -ProtectedFromAccidentalDeletion flag is set to $false, which means the OU can be deleted without requiring additional steps to remove deletion protection.
5. User Account Creation Loop: For each name in the names.txt file, the script:
- Splits the name into first and last names.
- Constructs a username by taking the first letter of the first name and appending the full last name, all in lowercase.
- Outputs a message indicating it's creating a user account for the username.
- Calls New-AdUser to create the new user account with the specified attributes and places it in the _USERS OU. Key parameters include the user's first name, surname, display name, an employee ID set to the username, and a flag to ensure the password never expires.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/c35a6871-14b3-40fc-a77f-a13d28de5bef" width="500">

## Creating Windows 10 Pro VM
This machine is crucial for testing and utilizing the Active Directory setup
- note that the home edition should not be selected as the edition lacks the ability to connect a domain
- 
**Step 1: Prepare Virtual Environment**
1. Launch Your Virtualization Software: Open your preferred virtualization platform, such as VMware Workstation, Oracle VM VirtualBox, or Microsoft Hyper-V Manager.
2. Create New VM: Initiate the creation of a new virtual machine. This process varies depending on your software but generally involves selecting "New" or "Create a new virtual machine" from the file or home menu.

**Step 2: Configure VM Settings**
1. Select ISO Image: When prompted for an installation source, choose the ISO image option. Browse and select your Windows 10 Pro ISO file. Ensure this ISO is accessible by the VM.
2. Allocate Resources: Assign the VM a reasonable amount of RAM and CPU cores based on your host system's capabilities and the expected workload. For a standard Windows 10 Pro VM, allocating at least 2 CPU cores and 4 GB of RAM is recommended.
3. Network Adapter: Choose "Internal Network" for the network adapter setting. This configuration ensures that the VM can communicate within your network setup, particularly important for Active Directory domain joining and internal network access.

**Step 3: Install Windows 10 Pro**
1. Start the VM: Power on the virtual machine. It should boot from the ISO image provided.
2. Installation Type: When prompted by the Windows setup, opt for a "Custom: Install Windows only (advanced)" installation. This option is for clean installations without preserving old files or applications.
3. Partitioning: You'll be prompted to select a drive for installation. If this is a new VM, you'll likely need to format the virtual disk. Proceed with formatting and then select the newly formatted space for Windows installation.
4. Follow Installation Prompts: Continue with the installation process by following the on-screen prompts. This will include setting up basic preferences, accepting license terms, and configuring settings.

**Step 4: Finalizing Setup**
1. Install VM Tools: Once Windows installation completes and you've reached the desktop, install your virtualization platform's guest tools (e.g., VMware Tools for VMware, Guest Additions for VirtualBox). This improves performance and usability, including better mouse and display integration.
2. Join the Domain: To join your Active Directory domain, open the System Properties dialog by right-clicking on "This PC" on the desktop or in File Explorer and selecting "Properties". Then, click on "Change settings" next to the computer name. In the "System Properties" window, go to the "Computer Name" tab and click "Change...". Here, you can change the member of from "Workgroup" to "Domain", entering your domain name. You'll be prompted for credentials; use an account with permissions to join computers to the domain.
3. Restart and Login: After joining the domain, you'll need to restart the computer. Upon restart, you can log in with domain credentials.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/3162b70f-04af-46d0-bb10-1b061d220253" width="500">

To ensure that the VM is fully integrated into the network the connectivity needs to be tested
**Step 1: Test Network Connectivity**
1. Open Command Prompt: Press Windows key + R to open the Run dialog, type cmd, and press Enter to open Command Prompt.
2. Ping Google:
- To verify internet connectivity, type ping google.com and press Enter.
- You should see replies from Google's IP address, indicating that your VM has internet access through NAT (Network Address Translation) provided by your domain controller.
3. Ping Your Domain:
- To check connectivity to your domain, type ping mydomain.com and press Enter.
- You should receive replies from the IP address of your domain controller, indicating that the VM can communicate with your Active Directory domain.
