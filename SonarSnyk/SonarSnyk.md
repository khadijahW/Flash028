# SonarSnyk
## Intoduction

In this project I will use SAST, DAST, Dependencies, and Secrets Scanning with SonarQube and Snyk

1. SonarQube
- SAST(Static Appication Security Testing) for finding code quality issues and vulnerabilties
2. Snyk
- Software composition Analysus(SCA) scans for known vulnerabiltieis in open-source dependencies.
- support container image scanning and IaC misconfiguration detection


## Installation Instructions

1. Install and Configure PostgreSQL on Windows
- Download PostgreSQL:
- Visit [PostgreSQL Downloads](https://www.postgresql.org/download/windows/)
Download and run the installer for your version of Windows.
Run the PostgreSQL Installer:
During installation:
Set a password for the default PostgreSQL user (postgres).
Install all components, including pgAdmin (a GUI for managing PostgreSQL).



## Create a SonarQube Database:
1. Open pgAdmin 4  and log in using the credentials you set during installation.
2. Right-click Databases > Create > Database:
3. Database Name: sonarqube
4. Owner: postgres
5. Click Save.
   
![SonarQube Database Creation in Postgres](https://github.com/khadijahW/Flash028/blob/fba56ac966190cdc109bc5b0b98c0e395079fb62/SonarSnyk/databasecreation.png)


## Installing SonarQube
1. Install and Configure SonarQube on Windows
- Download SonarQube:
- Go to [SonarQube Downloads](https://www.sonarsource.com/products/sonarqube/downloads/).
- Download the latest version of SonarQube Community Edition.
- Extract SonarQube:
- Unzip the downloaded file to a folder, e.g., C:\SonarQube.
- Configure SonarQube to Use PostgreSQL:


Open the sonar.properties file in C:\SonarQube\conf using a text editor.
Find and update the following properties:
properties
Copy
Edit
sonar.jdbc.username=postgres
sonar.jdbc.password=your_password
sonar.jdbc.url=jdbc:postgresql://localhost:5432/sonarqube
Start SonarQube:

Navigate to the C:\SonarQube\bin\windows-x86-64 folder.
Double-click StartSonar.bat.

## Accessing SonarQube
Once started, open your browser and go to http://localhost:9000.
Default credentials: admin / admin (you’ll be prompted- to change the password).


## Snyk Installlation
3. Set Up Snyk for Dependency and Secrets Scanning
Install Node.js:
Download and install the latest Node.js from Node.js Downloads.
During installation, check the box to install npm (Node Package Manager).
Install the Snyk CLI:

Open Command Prompt and run:
 cmd -> Copy ->Edit -> npm install -g snyk 

Authenticate Snyk:
Run: -> cmd -> Copy -> Edit -> snyk auth
- This will open a browser window where you can log in to your Snyk account.
Run Dependency and Secrets Scanning:

Navigate to your project folder in Command Prompt:
cmd -> Copy -> Edit
cd C:\path\to\your\project

# Scanning Dependencies 
Scan for dependencies:
cmd -> Copy -> Edit -> snyk test

# Scanning for Secrets 
Scan for secrets:
cmd
Copy
Edit
snyk code

# Sample Project 
4. Create and Analyze a Sample Project
Create a Simple Project:
Use a basic programming project for testing, e.g., a Node.js or Python project.
Example: Create a simple Node.js app:
cmd
Copy
Edit
mkdir C:\MyProject
cd C:\MyProject
npm init -y
npm install express
Add a simple app.js file:
javascript
Copy
Edit
const express = require("express");
const app = express();
app.get("/", (req, res) => res.send("Hello, world!"));
app.listen(3000, () => console.log("App running on port 3000"));
Analyze the Project with SonarQube:

Install the SonarScanner CLI:

Download the scanner from SonarQube Scanner Downloads.
Extract it to a folder, e.g., C:\SonarScanner.
Configure the scanner:

Open C:\SonarScanner\conf\sonar-scanner.properties and set:
properties
Copy
Edit
sonar.host.url=http://localhost:9000
sonar.login=your_sonarqube_token
Replace your_sonarqube_token with a token from the SonarQube UI under My Account > Security.
Run the scanner in your project directory:

cmd
Copy
Edit
sonar-scanner
View the Results:

Open http://localhost:9000 in your browser to view the analysis in SonarQube.
5. (Optional) Add a DAST Tool
For DAST (Dynamic Application Security Testing), you can integrate OWASP ZAP.
Download ZAP from OWASP ZAP Downloads.
Configure ZAP to scan your running app (http://localhost:3000).
6. Project Recap
SonarQube: SAST (Static Analysis).
Snyk: Dependency, container scanning, and secrets detection.
OWASP ZAP (Optional): DAST.
PostgreSQL: Database for SonarQube.
