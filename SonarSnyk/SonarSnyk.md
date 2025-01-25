# SonarSnyk
## Intoduction

In this project I will use SAST, DAST and SCA tools to check code for vulnerabilities.

1. SonarQube
- SAST(Static Appication Security Testing) for finding code quality issues and vulnerabilties
2. Snyk
- Software composition Analysis(SCA) scans for known vulnerabiltieis in open-source dependencies.
- support container image scanning and IaC misconfiguration detection
3. OWASP ZAP
- DAST(Dynamic Application Security Testing)
4. Docker
- for containerize SonarQube and Postgre


## Creating Containers 
Install Docker Desktop App
- then open cmd and run
  ```
  wsl --install
  ```
  
## In vscode 
```sh
note this code including password are from edX labs:no actual passwords are exposed 
docker network create mynet
```
## Setting up Postgres Container
```
docker run --name postgres  -e POSTGRES_USER=root -e POSTGRES_PASSWORD=Test12345  -p 5432:5432 --network mynet -d postgres

to set up a sonarqube container on port 9000

docker run -d --name sonarqube -p 9000:9000 -e sonar.jdbc.url=jdbc:postgresql://postgres/postgres -e sonar.jdbc.username=root -e sonar.jdbc.password=Test12345 --network mynet sonarqube
```
## To set up a SonarQube Container

```
note this code including password are from edX labs:no actual passwords are exposed 
docker run -d --name sonarqube -p 9000:9000 -e sonar.jdbc.url=jdbc:postgresql://postgres/postgres -e sonar.jdbc.username=root -e sonar.jdbc.password=Test12345 --network mynet sonarqube
```

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/fbb6c630-6f61-42ea-9714-a8c95091b6fc/13384c3c-14ae-451d-9f13-5be67976cf0c/image.png)

## Integrating SonarQube with Github
- In sonarqube go to projects and import from github

- configuration name: 
- Github API url: *https://api.github.com*
- Personal Access Token
- To create
  ```
  Navigate to your GitHub account settings.
  Click on Developer settings in the left sidebar.
  Select Personal access tokens.
  Click on Generate new token.
  Provide a descriptive name for the token (e.g., "SonarQube Integration").
  Set the expiration date as needed.
  Select the necessary scopes for the token. For SonarQube integration, the repo scope is typically sufficient.
  Click Generate token.
  Copy the generated token and store it securely; you won't be able to view it again.
   ```
Setting up the app integration 
```
developer settings
new github app
hompage url: url for sonarqube
callback url: for sonarqube
deselect active for Webhook
for permissions pull request is required to be write
Then install the application to all repositiories
```
![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/fbb6c630-6f61-42ea-9714-a8c95091b6fc/06d13c8d-3f35-4af7-bf24-8e66fd8d7f88/image.png)

Then in sonarqube click account 

- my account
- security and generate a new token for the repository to be scanned
- Then for that repository in github create that secret
![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/fbb6c630-6f61-42ea-9714-a8c95091b6fc/643d50ac-723a-4d0c-baaf-71ab4e835989/image.png)


Next copy the build and analysis code provided from sonarqube into a build.yml file 
- keep in mind that sonarqube is running in a docker container so the build will fail
    - download ngrok to expose the container
    - https://dashboard.ngrok.com/get-started/setup/windows
    - use the authentication token command provided after installation
    - then the command should be something like
      ```
      ngrok http <url for host>
      ```
      you will then be given a url called forwarding from the command and this will be replaced with the url in the build file
The yml file will look something like this
name: Build and Analyze
```
on:  

push:    

branches:      

- main

jobs:  

build:   

name: Build and Analyze  

  runs-on: ubuntu-latest   

 steps:    

  - uses: actions/checkout@v4        

with:         

 fetch-depth: 0  # Ensure full history for accurate analysis     

 - uses: SonarSource/sonarqube-scan-action@v4     

   env:        

  SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}       

  SONAR_HOST_URL: https://<someextainfohere>.ngrok-free.app

  ```
Running the yml workflow file with Github Actions
![image.png](attachment:f15cdc08-a097-417f-8439-dbc07268a88f:image.png)

The results of the SonarQube Scan
![image.png](attachment:8bc989ae-d581-44ad-951e-209b57fd0a37:image.png)
