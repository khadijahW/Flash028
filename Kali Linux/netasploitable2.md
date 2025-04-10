
# Metasploitable 

![image](https://github.com/user-attachments/assets/077df3c9-a9c5-4e5b-8d59-ae6ad2b86007)

It’s intentionally vulnerable, so exposing it to the internet is a major security risk (it could be compromised within minutes and used for attacks).

VMware:
- Go to VM Settings > Network Adapter
- Set to Host-only or Custom (VMnet1)
- This keeps it isolated to your machine.

  ![image](https://github.com/user-attachments/assets/352259c7-8f6a-43b9-a42b-1c18af50c23b)

## Vulnerability Scanning 
```
nikto -h <machine's ip>
```
![image](https://github.com/user-attachments/assets/8a3fbce8-427f-4e60-ad68-05273d298c2e)

As indicated by the results 
- Apache/2.2.8 appears to be outaded
- HTTP TRACE method is active which suggests the host is vulnerable to XST

```
nmap -A -p- [Metasploitable_IP] -oN full_scan.txt
```
-Running a full nmao scan - A(Aggressive) -p(scanning all ports) -oN( output to file)

### Searchsploit ( included with kali linux)
- helps you find known exploits from the Exploit-DB database:

### Install Nessus
https://www.tenable.com/downloads/nessus?loginAttempted=true
```
sudo dpkg -i Nessus-10.8.3-ubuntu1604_amd64.deb
```
```
sudo systemctl start nessusd.service
```
```
https://localhost:8834
```
