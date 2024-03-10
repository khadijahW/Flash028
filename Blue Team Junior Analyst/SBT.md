# BLUE TEAM JUNIOR ANALYST 

## Overview

Welcome to my repository where I share the comprehensive journey, insights, and resources from my experience pursuing and earning the Security Blue Team (SBT) certification, specifically the Blue Team Junior Analyst.

## Table of Contents

- [Introduction to Network Analysis](#intoduction-to-network-analysis)
- [Introduction to OSINT](#introduction-to-osint)
- [Introduction to Dark Web Operations](#introduction-to-dark-web-operations)
- [Introduction to Threat Hunting](#introduction-to-threat-hunting)


## Introduction to Network Analysis
This module consisted of delving into the basics of network analysis, understanding network protocols, and learning how to monitor network traffic for signs of anomalous or malicious activity.

**TOOLS USED**
- Wireshark
  
**CHALLENGE QUESTIONS**
PCAP 1
1. Which protocol was used over port 3942?

<img src="https://github.com/khadijahW/Flash028/assets/99515087/03823c79-b031-4d6d-9ccb-c4dde15f520f" width="500">

2. What is the IP address of the host that was pinged twice?

<img src="https://github.com/khadijahW/Flash028/assets/99515087/03823c79-b031-4d6d-9ccb-c4dde15f520f" width="500">


3. How many DNS query response packets were captured?
   
<img src ="https://github.com/khadijahW/Flash028/assets/99515087/8a711f3a-5359-46be-b34f-de1c010fa2a3" width ="500">

4. What is the IP address of the host which sent the most number of bytes?
   
 <img src ="https://github.com/khadijahW/Flash028/assets/99515087/9ebe71a8-f51c-42f9-a8cc-5181be50b2f0" width="500">


PCAP 2
1. What is the WebAdmin password?
<img src =" https://github.com/khadijahW/Flash028/assets/99515087/e914a3c0-86c4-4d4c-b9a1-28e0aec7aa1c" width="500">

<img src ="https://github.com/khadijahW/Flash028/assets/99515087/709e83c9-c120-4267-83bb-20268e31dc1e" wifth="500">
   
3. What is the version number of the attacker’s FTP server?
4. Which port was used to gain access to the victim Windows host?
5. What is the name of a confidential file on the Windows host?
6. What is the name of the log file that was created at 4:51 AM on the Windows host?

<img src= "https://github.com/khadijahW/Flash028/assets/99515087/cfe65c34-0967-4b6b-8663-d6adab9dc086" width="500">


## Introduction to OSINT
This section focused on exploring the tools and techniques for gathering information from publicly available sources to support cybersecurity defenses and threat intelligence efforts.

**TOOLS USED**
- Maltego: I used this tool after the lab to find the same information and setting the Sp1ritFyre Twitter handle as an entity to begin searching for other information.
- Base64
- Google
<img src="https://github.com/khadijahW/Flash028/assets/99515087/f3d30e49-eab7-4387-984c-1ed40e30f870" width="600">

<img src="https://github.com/khadijahW/Flash028/assets/99515087/e4bf97bd-69ab-4b00-9e70-d23fe5aaa922" width="500">

**METHODOLOGY**

To navigate through this segment. I begin by visiting the provided Twitter account, Sp1ritFyre. This account contained a link, which upon exploration lead to anu nexpected deade end. I then began investing the light bulb image prominently displated on the Twitter profile. This image me directed me towards a Facebook page. Although the intial discovery seemed promising, the Facebook account ultimately fell short of providing any leads on identifying the hacker. I then decided to turn to Google directly with the Twitter handle, Sp1ritFyre, as my search keyword. This unveiled a blog site.

Below, is a visual snapshot of the blog site.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/b3bd0950-86e3-4aa9-8ae8-deff101834df" width="600">

I immediately noticed that it contain an image of the same lightbulb I discovered in the twitter account. Examining the send lead me to find the email d1ved33p@gmail.com and indicated that the blog belonged to a female. I then googled the email address and found another site displaying that the owner was female,had the username Sp1ritFyre and displayeed the same email address.


<img src="https://github.com/khadijahW/Flash028/assets/99515087/e5b6be1c-14cc-4ef5-ae5e-90b572c241d8" width="600">


The name displayed is Sam Wood. I begin probing this site for additional information and viewed the archive section and discovered a github account. I then viewed the complete profile and found that her full name is Sammie Woods.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/4c3b9e9b-b90e-4a26-99ff-5923c139cd1f" width="600">

Reading the section her occupation is a Junior Penetration Tester and she is employed as Philman Security Inc. Reviewing the challenge tips, it expressed that some information may be decoded. I then then reflected back to the twitter account in which the link had no destination. 

<img src= "https://github.com/khadijahW/Flash028/assets/99515087/49b31f4a-a213-48d5-a23d-4edf3ac5d3c2" width="600">

So, I entered the link into Base64 decoder.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/bdd2baf3-fa1c-41f4-acde-d38b9aff151c" width="600">

I found that the website was redhunt.net and additional information displaying the associated email for the website used by the hacker.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/f7a82835-4804-4d6b-bc41-e4c95b4bc2d5" width="600">


## Introduction to Dark Web Operations
  
<img src="https://github.com/khadijahW/Flash028/assets/99515087/897b73dd-3130-4546-bbeb-50d217bf7cba" width="500">

This section reviews dark web operation and provides information regarding the surface,deep and dark web. Provded are images of the challenge scenario and challenge report questions.

<img src ="https://github.com/khadijahW/Flash028/assets/99515087/553b523c-7047-49ae-a3d8-a3da00acf0ca" width =" 500">

This is an image of the questions included in the final capstone for the module in which I was required to enter to complete that section.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/9c6c9105-889f-4ec4-9680-c80c0a5beec7" width="500">

Steps to begin this lab consisted of:
1. Downloading TOR browser
2. Turning on a VPN
3. Then visiting the provided website, which allowed me to access the website seen in the image below.


<img src="https://github.com/khadijahW/Flash028/assets/99515087/d1481f38-ca40-4e49-8953-de12b2896bcf" width="500">

I right clicked and inspected the website and utilized the console tab to find user credential by using 
-  generateUserCredentials()
<img src="https://github.com/khadijahW/Flash028/assets/99515087/c2a3fe12-fe8e-4e87-8337-84980e0872ae" width="500">

Referencing the OSINT Framework for tools utilized cyberchef for decoding to find the username and password.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/566856b1-3c72-4f33-acd1-d31e07e66717" width="500">

I then utilizsed these credentials to access the site's home page. I immediately noticed that several pages were encoded.


<img src="https://github.com/khadijahW/Flash028/assets/99515087/937d207e-31e6-4093-a0f7-7fb0e20e191f" width="500">

Using cyberchef, I discoved that this site says "Authentic Switzerland's choclate. You're tired of not finding good chocolate? This post is for you."

<img src="https://github.com/khadijahW/Flash028/assets/99515087/ed34bdb2-0d3c-442a-ad7f-2da225f81095" width="500">

Decoding the information of the image from left to right:
- Guns WANNA KNOW HOW TO BUY YOUR GUNS?, THIS IS FOR YOU
- Recreational Drugs Buying/Selling Let the party begins! (Everything you wanna know about drug dealing)
- Hey dude... wanna candy? (The real D king!)Deliver the package, collect the money and live like a king!
- BBB Organs for sale Are you such an alcoholic that your kidney stopped working? Don't worry, we can get you a new one

Further inspecting the site there was an image of a passport in which I utilized tp discover the name and country of the suspect.
<img src="https://github.com/khadijahW/Flash028/assets/99515087/4314df53-f124-4cbf-bf3e-39fc35430e85" width="300">


## Introduction to Threat Hunting
In this section I learned proactive cybersecurity techniques aimed at detecting and mitigating threats before they exploit vulnerabilities within an organization's network.

**TOOLS USED**
- Redline
- Mandiant
- Powershell
  
<img src="https://github.com/khadijahW/Flash028/assets/99515087/e304b429-b703-4308-aabd-046059e102c3" width="600">

In this image, I created the criteria for detecting IOC's such as the:
- File MD5 value
- File name 
- File size
- File Sha1sum
<img src="https://github.com/khadijahW/Flash028/assets/99515087/655dc5cf-dd5c-4911-8968-a4a4055bf3c2" width="500">

To facilitate the process of not having to collect the MD5 and SHA1 value. I utilized and script that would read in each file and output the value for MD5 and SHA. THe output of this script is provided below.

<img src= "https://github.com/khadijahW/Flash028/assets/99515087/f89ba62a-9a0b-435b-a4f5-5d04aa373c54" width="500">

Provided below is IoC report scan ran in Redline. This report shows the hits from the reported IoCs that Redline used to scan for matches against the IoCs to identify potential signs of mailicous activity.

<img src="https://github.com/khadijahW/Flash028/assets/99515087/57bf7281-d12d-4e0c-b4dc-7228dba87c41" width="500">


