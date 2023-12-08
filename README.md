# README 
 
## Introduction ## 

Our team is creating an application for the Texas A&M Association of Baptist Students organization. This application will serve as an alumni directory, enabling each member (current or former) to list themselves and search for others. Alumni will be able to search for each other by information such as First and Last Name, Class Year, Major, and Current City. In addition, administrators will be able to post meeting notes (including sermons) for all alumni to see. Alumni will be able to post prayer requests and choose whether to share them publicly or only with administrators of the org. Finally, administrators will be able to add/remove/reorder links in the navigation bar to keep their donation links, etc., up to date and within close reach of alumni. 
 
## Requirements ## 
 
This code has been run and tested using the following internal and external components 
 
Environment 
•	Debian 11 
•	Docker Engine v4.22.1 
•	Docker container paulinewade:csce431/latest (5f3348786425) 
•	Heroku v7.60.2 
 
Program 
•	Ruby v3.1.2 
•	Rails v7.0.8 
•	Rspec-rails v6.0.3 
•	PostgreSQL v13.7 
•	devise v4.9.2 
•	omniauth v1.9.2 
•	google-api-client v0.53.0 
•	google-apis-drive_v3 v0.44.0 
•	omniauth-google-oauth2 v0.8.2 
•	httparty v0.21.0 
 
Tools 
•	GitHub - main branch with LINK to repo 
•	RuboCop v1.56.3 
•	Simplecov v0.22.0 
•	Brakeman v6.0.1 
•	Jira 
•	VS Code v1.84.2 
•	VIM 
 
## External Deps 
 
- Docker - Download latest version at https://www.docker.com/products/docker-desktop 
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli 
- Git - Download latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git 
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/ 

 
 
## Installation ## 
 
Download this code repository by using git: 
 
 `git clone https://github.com/FA23-CSCE431-SoftEng/project-turnover-associationofbaptiststudents_sprint_1` 

 

## Documentation 
 
Our product and sprint backlog can be found in Jira, with organization name [NAME] and project name [NAME] at the following link: 

https://association-of-baptist-students.atlassian.net/jira/software/projects/SCRUM/issues/ 

 
 
In our MS Teams repository, Turnover folder, we have the following latest version of internal documents 

Documents: 

Project Notebook v3 

Project Turnover report 1.0  

Team Working Agreement v1 

Scope v3 

Data Design v3 

Risk Plan v3 

UAT Form v3 

UAT Results:  UAT form filled in by the customer v3 

Customer Feedback Survey Results v1 

Efficiency Summary v1 

User / Admin / System Documentation 

Heroku Documentation v1 

 
 
## Execute Code ## 
 
In order to run the app, you must first spin up the associated docker container. CD into the folder for this repository then run: 
 
`docker run --rm -it --volume "$(pwd):/csce431" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade:csce431/latest` 

Now you are executing commands inside the docker container. 
 
Install the app 
 
  `bundle install && rails db:create && rails db:migrate && rails db:seed` 
 
Run the app 
  `rails server --binding:0.0.0.0` 
 
The application can be seen using a browser and navigating to http://localhost:3000/ 
 
## Tests ## 
 
An RSpec test suite is available and can be ran on the docker container using: 
 
  `rspec .` 
 
## Environmental Variables/Files ## 
 
Google OAuth2 support requires two keys to function as intended: Client ID and Client Secret 
 
Create a new file called application.yml in the /config folder and add the following lines: 
 
  `GOOGLE_OAUTH_CLIENT_ID: 'YOUR_GOOGLE_OAUTH_CLIENT_ID_HERE'` 
 
  `GOOGLE_OAUTH_CLIENT_SECRET: 'YOUR_GOOGLE_OAUTH_CLIENT_SECRET_HERE'` 

** To change these and add them to Heroku if necessary, follow the Heroku Documentation guide in Turnover folder ** 
 
 

## Deployment ## 
 
Setup a Heroku account: https://signup.heroku.com/ 
 
From the heroku dashboard select `New` -> `Create New Pipeline` 
 
Name the pipeline, and link the respective git repo to the pipline 
 
Our application does not need any extra options, so select `Enable Review Apps` right away 
 
Click `New app` under review apps, and link your test branch from your repo 
 
Under staging app, select `Create new app` and link your main branch from your repo 

While the app builds, click on the app name, and go to resources. From the Add-on section, add a Heroku Postgres to it for the database. 
 
-------- 
 
To add environment variables to enable google oauth2 functionality, head over to the settings tab on the pipeline dashboard 
 
Scroll down until `Reveal config vars` 
 
Add both your client id and your secret id, with fields `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` respectively 
 
Now once your pipeline has built the apps, select `Open app` to open the app 
 
With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production` 
 
And now your application is setup and in production mode! 
 

## CI/CD ## 
 
For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated. 
 
  `Review app: test branch` 
 
  `Production app: main branch` 
 
For continuous integration, we set up a Github action to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended. 
 
## Support ## 
 
Admins looking for support should first look at the application help page provided on each page on the website. 

Admins can also refer to the help videos provided in the following google drive: https://drive.google.com/drive/u/1/folders/1Xt0lKA5aq7VU4-pvnXev10mH_y8O2GMv 

  
Users looking for help seek out assistance from the customer.