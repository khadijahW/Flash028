## Active Directory Lab
**Description**
This project aims to simplify the setup and management of Active Directory (AD) environments. It includes scripts, configuration templates, and documentation designed to automate and streamline the deployment, management, and troubleshooting of Active Directory services. 

**Prerequisites**
- Windows Server 2019 or newer.
- PowerShell 5.1 or newer.
- VMWARE or Virtual Box

This guide outlines the detailed steps to I used to set up an Active Directory environment on a Windows Server 2019 instance running in Oracle VM VirtualBox. This setup is crucial for creating a controlled, simulated network environment for testing and development purposes.

**Step 1: Install Windows Server 2019 on VirtualBox**
-Setting up the Virtual Machine
  - I started by ensuring Oracle VM VirtualBox was installed on my host machine. Then, I created a new virtual machine (VM), selecting "Windows Server 2019" as the operating system. This was the first step in establishing the foundation for my Active Directory lab.
- Adjusting Network Settings
  -Next, I configured two network adapters for the VM to facilitate its operation within a simulated network environment:
- Adapter 1: I set to NAT to allow the server to access the internet. This connection was essential for updates and software installations, ensuring my server was up to date and secure.
- Adapter 2: I configured as an Internal Network. This setting was crucial for creating a controlled environment that mimicked a real-world network topology. It enabled seamless communication within my virtualized network environment, allowing me to test and develop in a realistic setting.
  <img src= "https://github.com/khadijahW/Flash028/assets/99515087/e89018da-4738-4fbb-8f7e-d1b61ffb59c4" width="500">
**Step 2: Initial VM Configuration**

Continuing with my setup process, I moved on to enhancing the interaction between my host machine and the Virtual Machine (VM) to make my work easier and more efficient.

**Inserting Guest Additions CD Image**
To achieve this, I navigated to the "Devices" menu in the VirtualBox interface and selected "Insert Guest Additions CD Image." This action was essential for improving functionalities such as clipboard sharing and window scaling, which are critical for an efficient workflow when managing multiple environments.

**Installing Guest Additions**
Once the Guest Additions CD Image was inserted, I opened File Explorer within the VM and navigated to the CD drive that contained the VirtualBox Guest Additions. I found the installer suitable for AMD64 systems and ran it. The installation process was straightforward and, upon completion, required a shutdown of the VM to apply the changes effectively.


**Step 3: Network Configuration Inside the VM**

**Accessing Network and Sharing Center**
First, I navigated to the Control Panel within the VM, selected "Network and Internet," and then went to the "Network and Sharing Center." From there, I clicked on "Change adapter settings" to view and manage the network adapters.

**Identifying and Renaming the NAT Adapter**
Among the listed adapters, I identified the one connected to the Internet, which was using NAT (Network Address Translation). By right-clicking on this adapter, selecting "Status," and then "Details," I was able to note the IP address, which was in the 10.0.X.X range. Recognizing the importance of clear and easy identification for future steps, I renamed this adapter to "Internet."

**System Rename for Domain Controller**
The next crucial step involved renaming the computer to prepare it for its role as a Domain Controller (DC). By right-clicking on the Start button and selecting "System," I was able to access the system properties and rename the computer to "DC." I followed the prompts to restart the computer, a necessary action to ensure the name change took effect.

**Step 4: Configuring IP Address for the Internal NIC**

**Setting the Static IP for the Internal Network Adapter**
I navigated back to the "Network and Sharing Center" and clicked on "Change adapter options" to access the network adapters. I right-clicked on the adapter that was designated for the internal network (not the one I had renamed to "Internet") and selected "Properties" from the context menu.

**Configuring IPv4 Settings**
In the adapter's properties, I focused on the "Internet Protocol Version 4 (TCP/IPv4)" item and clicked on "Properties" to configure its settings. I entered the following details to set up a static IP address:

- IP address: I set this to 172.16.0.1, choosing an address that would not conflict with other devices on my network and would be easy to remember.
- Subnet mask: I configured this as 255.255.255.0, which is standard for creating a subnet of this size, providing ample addresses for my lab environment.
- Default gateway: I left this field empty because the static IP was purely for internal network purposes, and this adapter would not be used to access external networks.
- Preferred DNS server: I set this to 127.0.0.1, pointing back to the DC itself. Since the DC would be configured as a DNS server during the Active Directory setup, this ensured that the DNS resolution would start with the local machine, aiding in network efficiency and security.


## Adding Roles and Configuring Active Directory Domain Services ##

<img src= "https://github.com/khadijahW/Flash028/assets/99515087/01e499fa-3619-4827-81ee-c8246d55ee20" width="500">

**Step 5: Launch Server Manager**

Once my VM was up and running again, I opened Server Manager directly from the Start menu. It's also accessible from the taskbar if it's pinned there, offering a straightforward way to jump into the management of server roles, features, and overall system configuration.

**Step 6: Add Roles and Features**
Continuing with the setup of my Active Directory lab, I moved on to initiating the wizard for adding roles and features.

**Initiating the Wizard**
- From the Server Manager dashboard, I located and clicked on "Add roles and features." This action launched the Add Roles and Features Wizard, which is designed to guide users through the installation process in a step-by-step manner.

**Choosing Installation Type**
- Within the wizard, I was presented with various installation type options. I ensured that the "Role-based or feature-based installation" option was selected. This option is essential for setting up specific roles on the server. After selecting it, I clicked "Next" to proceed.

**Server Selection**
- The next step brought me to the Server Selection phase. Here, the wizard automatically highlighted my current server, which is the standard behavior when you're working directly on the server you intend to configure. I confirmed that my server was selected and then clicked "Next" to continue.

**Adding Active Directory Domain Services Role**
- In the Roles list, I scrolled until I found "Active Directory Domain Services" and selected it. This action is pivotal as it initiates the addition of the primary role necessary for creating a domain environment.
- Upon selecting Active Directory Domain Services, a new window popped up, suggesting adding features that are required for AD DS. I clicked "Add Features" on this prompt, acknowledging the necessity of these additional features for a fully functional AD DS environment.
- After adding the necessary features, I clicked "Next" to proceed. I chose to skip the Features section by leaving everything at their default settings, as recommended for most standard setups, and clicked "Next" again.
**Confirmation and Installation**
- The wizard then presented me with a summary of my selections for review. After verifying that everything was correctly set up, I clicked "Install." The installation process began, with the comforting note that no restart would be required immediately, allowing me to continue using the server or even close the wizard. 

**Step 7: Configure Active Directory Domain Services**
- Launching AD DS Configuration
  - I noticed a notification flag with a yellow exclamation mark at the top right corner of the Server Manager dashboard, indicating the completion of the role installation. Clicking on this flag revealed a drop-down menu, from which I selected "Promote this server to a domain controller." This action launched the Active Directory Domain Services Configuration Wizard.
- Promotion Wizard Steps
- Deployment Configuration
  - Within the wizard, I chose "Add a new forest" since this was the initial setup and I was creating a new domain. In the "Root domain name" field, I entered my desired domain name (e.g., "mydomain.com"), marking the beginning of setting up my own domain.
- Domain Controller Options
  - Following the wizard's steps, I was prompted to provide a Directory Services Restore Mode (DSRM) password. This password is crucial for recovery purposes, allowing access to the directory services restore mode in case the AD DS environment encounters a failure.
- DNS Options and Additional Options
  - I opted to leave the DNS options and additional options at their default settings, as my setup did not require any specific configurations at this stage.
- Paths
  - The default locations suggested by the wizard for the database, log files, and SYSVOL were acceptable for my environment, so I made no changes here.
- Review Options and Prerequisites Check
  - The wizard then presented a summary of my choices for review. After ensuring all configurations were correct, I proceeded with the prerequisites check.

**Step 8: Creating a Dedicated Admin Account**
Accessing Active Directory Users and Computers
I opened the "Active Directory Users and Computers" tool by clicking on the Start menu, navigating to the "Windows Administrative Tools" folder, and selecting "Active Directory Users and Computers." This tool is indispensable for AD management tasks.
Creating an Organizational Unit for Admin Accounts
1. Navigating to Your Domain

In the "Active Directory Users and Computers" window, I located my domain (e.g., "mydomain.com") in the left-hand pane. This pane provides a hierarchical view of all AD objects within the domain.
2. Creating a New OU

To create a new Organizational Unit (OU) specifically for administrative accounts, I right-clicked on my domain name, selected "New," and then chose "Organizational Unit." I named this new OU "ADMIN," a label that clearly identifies its purpose for anyone managing the AD environment.
Creating a New Admin User
After establishing the ADMIN OU, it was time to create a new administrative account within this OU. This account would be used for high-level administrative tasks within the domain, separate from the default Administrator account, offering a layer of organization and security.

**Steps to Create a New Admin User:**
1. Right-Click on the ADMIN OU: In the "Active Directory Users and Computers" window, I right-clicked on the ADMIN OU I had just created. This action opened a context menu offering various options for managing the OU.
2. Select 'New' then 'User': From the context menu, I selected "New" and then "User." This launched a wizard to guide me through the user creation process.
3. Enter User Details: In the wizard, I entered the necessary details for the new admin user, including the first name, last name, and user logon name. It's important to follow your organization's naming conventions for consistency and identification.
4. Set Password and Account Options: I was prompted to create a password for the new user and select account options. For an admin account, it's crucial to choose a strong, secure password. I also made sure to set the account options appropriately, such as password never expires or user cannot change password, depending on the security policies in place.
5. Complete the User Creation: After filling in all the details and setting the account options, I clicked "Finish" to create the new admin user account within the ADMIN OU.

## Installing Remote Access and Configuring NAT
**Step 1: Install Remote Access Role**

1. Opened Server Manager from the Start menu.
2. licked "Manage" in the top-right, then "Add Roles and Features."
3. Clicked "Next" on the "Before you begin" page.
4. Selected "Role-based or feature-based installation" and clicked "Next."
5. Confirmed the server selection was correct and clicked "Next."
6. Chose "Remote Access" from the server roles, clicked "Add Features" when prompted, then "Next."
7. Left the default features as is and clicked "Next."
8. On the Remote Access page, clicked "Next," then chose "Routing" on the Role Services page and clicked "Next."
9. Reviewed selections and clicked "Install." Waited for the installation to finish.

**Step 2: Configure NAT using Routing and Remote Access**
1. Open Routing and Remote Access: After finishing the installation, I went back to Server Manager, clicked on "Tools" at the top right, and chose "Routing and Remote Access" from the list.
2. Server Setup: In the Routing and Remote Access console, I right-clicked my server's name and selected "Configure and Enable Routing and Remote Access."
3. Run Setup Wizard: The setup wizard opened. I clicked "Next" on the first screen. Then, I picked "Network address translation (NAT)" to let my private network clients use one public IP address for internet access and clicked "Next."
4. Choose Public Interface: I selected the interface connected to the internet, the one marked as "Internet" in my settings, making sure the option "Use this interface to connect to the internet" was checked before clicking "Next."
5. Finalize Setup: I followed the remaining steps in the wizard to complete the setup, turning my server into a NAT gateway for client devices.
6. Check Service Status: Back in the Routing and Remote Access console, I saw my server's icon displayed with a green arrow, indicating everything was up and running correctly

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
1. Environment Setup: I started by setting the execution policy of PowerShell to Unrestricted to allow scripts to run. This step is crucial for environments that default to restricted execution policies, which could prevent the script from running.
2. Script Parameters:
- $PASSWORD_FOR_USERS defines a default password for all users created by this script. It's set to "Password1", which should ideally be replaced with a more secure password in a real-world scenario.
- $USER_FIRST_LAST_LIST gets the content of a file named names.txt located in the current directory. This file contains the first and last names of the user accounts being created.
3. Secure Password Conversion: The plaintext password is converted to a secure string, which is a requirement for setting the account password in Active Directory through PowerShell.
4. Creating an Organizational Unit (OU): The script creates a new OU named _USERS where all the user accounts will be placed. The -ProtectedFromAccidentalDeletion flag is set to $false, which means the OU can be deleted without requiring additional steps to remove deletion protection.
5. User Account Creation Loop: For each name in the names.txt file, the script:
- This splits the name into first and last names.
- Then it constructs a username by taking the first letter of the first name and appending the full last name, all in lowercase.
- It then outputs a message indicating it's creating a user account for the username.
- The new user account is created  with the specified attributes and places it in the _USERS OU. Key parameters include the user's first name, surname, display name, an employee ID set to the username, and a flag to ensure the password never expires.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/c35a6871-14b3-40fc-a77f-a13d28de5bef" width="500">

## Creating Windows 10 Pro VM

Note that the home edition should not be selected as the edition lacks the ability to connect a domain 
**Step 1: Prepare Virtual Environment**
1. Launch Your Virtualization Software: Open your preferred virtualization platform, such as VMware Workstation, Oracle VM VirtualBox, or Microsoft Hyper-V Manager.
2. Create New VM: Initiate the creation of a new virtual machine. This process varies depending on your software but generally involves selecting "New" or "Create a new virtual machine" from the file or home menu.

**Step 2: Configure VM Settings**
1. Select ISO Image: When prompted for an installation source, choose the ISO image option. Browse and select your Windows 10 Pro ISO file. Ensure this ISO is accessible by the VM.
2. Allocate Resources: Assign the VM a reasonable amount of RAM and CPU cores based on your host system's capabilities and the expected workload. For a standard Windows 10 Pro VM, allocating at least 2 CPU cores and 4 GB of RAM is recommended.
3. Network Adapter: Choose "Internal Network" for the network adapter setting. This configuration ensures that the VM can communicate within your network setup, particularly important for Active Directory domain joining and internal network access.

**Step 3: Install Windows 10 Pro**
1. Start the VM: Power on the virtual machine. It should boot from the ISO image provided.
2. Installation Type: Opt for a "Custom: Install Windows only (advanced)" installation. This option is for clean installations without preserving old files or applications.
3. Partitioning: Then select a drive for installation. 
4. Follow Installation Prompts: Continue with the installation process by following the on-screen prompts. This will include setting up basic preferences, accepting license terms, and configuring settings.

**Step 4: Finalizing Setup**
1.  Join the Domain: To join your Active Directory domain, open the System Properties dialog by right-clicking on "This PC" on the desktop or in File Explorer and selecting "Properties". Then, click on "Change settings" next to the computer name. In the "System Properties" window, go to the "Computer Name" tab and click "Change...". Here, you can change the member of from "Workgroup" to "Domain", entering your domain name. 
2. Restart and Login: After joining the domain, I restarted the computer. Upon restart, I logged in with domain credentials.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/3162b70f-04af-46d0-bb10-1b061d220253" width="500">

To ensure that the VM is fully integrated into the network the connectivity needs to be tested
**Step 1: Test Network Connectivity**
1. Open Command Prompt: Press Windows key + R to open the Run dialog, type cmd, and press Enter to open Command Prompt.
2. Ping Google:
- To verify internet connectivity, type ping google.com and press Enter.
- You should see replies from Google's IP address, indicating that your VM has internet access through NAT (Network Address Translation) provided by your domain controller.
3. Ping Your Domain:
- To check connectivity to the domain, type ping mydomain.com and press Enter.
- Replies will then shpw from the IP address of the domain controller, indicating that the VM can communicate with the Active Directory domain.
