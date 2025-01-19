## Setting up AD server 




## Vault Installation 











## Setting Up PSM

Create a folder int the C- drive named CyberarkInstall
- drop the privileged session manager files here
- make sure that you have dotnet installed on the machine

1. Open powershell
2.eneter Set-ExecutionPolicy Bypass
3. Make sure that you are at the path C:\CyberarkInstall\InstallationAutomation\prerequsities
4. in powershell it should be .\Execute-Stage.ps1 "C:\CyberarkInstall\InstallationAutomation\prerequsities\PrerequisitesConfig"

1. Then add roles and features
2. Remote Desktop Services Installations
  -  standard deployment
  -  session based deployment

Then select the collection and then tasks to create a collection 
   
