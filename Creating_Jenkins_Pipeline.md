Jenkins Pipeline

Here we create a completely new pipeline for our jenkins from installing jenkins from scratch from our ec2's and deploying the sparta app through our own 
Jenkin's account through the use of creating jobs.

Before we get started we need to know what CI/CD is.

Continuous integration (CI) is a DevOps practice in which team members regularly commit their code changes to the version control repository, 
after which automated builds and tests are run. Continuous delivery (CD) is a series of practices where code changes are automatically built, tested
deployed to production.

Creating an AWS Instance 

Step 1 

- Create a name e.g `name-tech221-master-jenkins`
- Choose Ubuntu 18.04
- Make sure to click `t2.medium` as using micro, might overload the server and the pipeline, so using medium gives us enough CPU utilisation and space 
to work around 
- Key/pair tech221 and now we create out SG's which will create access ports connections from our local host to Jenkins 
- Launch the instance

Diagram

Step 2 

Create a Agent Node

All dependdencies to run the app folder has been installed within this instance.

- Create name e.g name-tech221-CI-Test and choose ubuntu 18.04
- Make sure to click `t2.micro` as our server would not overload and CPU would remain standard
- Key/pair `tech221` and now we create our SGs with the given access ports as below

Diagram 

Installing Jenkins on Ubuntu 18.04

Step 1 

- On git bash terminal, make sure to `.ssh` onto your instance of the master e.g `name-tech221-master-jenkins`
- Make sure you are logged in as a user with `admin` or be able to use `sudo`
- Then run the following commands

      sudo apt-get update
      #since Jenkins is a Java application, the first step is to install Java.
      sudo apt install openjdk-8-jdk

      #Import the GPG keys of the Jenkins repository using the following wget command:
      wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
      #add the Jenkins repository to the system with:
      sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
      sudo apt-get update
      sudo apt-get install jenkins
      sudo systemctl start jenkins
      sudo systemctl enable jenkins
      sudo systemctl status jenkins
      
      #Adjusting the firewall
      sudo ufw allow OpenSSH
      sudo ufw enable
      sudo ufw status
      
      # Displays the password when prompted by by jenkins on the browser
      sudo cat /var/lib/jenkins/secrets/initialAdminPassword    

Step 2 

- To Setup the jenkin's installation, open your browser and type your IP address from your AWS EC2 instance e.g `http://54.154.206.39:8080/` making sure
we add `:8080` at the end for Jenkin's.

Diagram

- From our previous commands we were given a password, to access jenkin's, so we just copy and paste the password e.g `0eefc4f9f74d4896a05bef8e294504d9` and click `continue` 

Step 3 

- A setup wizard will ask you whether you want to install suggested plugins or specific plugins. We chose `install suggested plugins`

Diagram

Step 4

- Now we setup our Admin `Username` and `password` for jenkins account.

Step 5 

- Once completed, this page will set the URL for your Jenkins instance which will be your primary URL.

Step 6

- Jenkins should be ready to use.

Diagram

Installing Plugins

These plugins are required to move further to use our Jenkins with our instance and create jobs to launch our sparta app.

- On Jenkins, go to `dashboard` and choose `manage jenkins`


- Click `Available Plugins`
- And install the following plugins either with `restart` or `without restart`.

      NodeJS Plugin
      Amazon EC2 Plugin
      Office 365 Connector
      SSH Agent Plugin
      GitHub plugin # Should have been automatically installed
      
Step 7

- Make changes through `global tool configuration`
- Scroll down to the `nodejs` plugin we had installed and edit the plugin to name (sparta-node-app), version `NodeJS 16`, then edit on 

`Global npm packages to install` and we paste `sudo npm install pm2 -g`

- Click save

diagram 

Final Step 

When build Job, it should automatically automate and be sucessfull without the use of creating a `dev` branch nor the AMI instance (`deploy job`)

Create a new pipeline

As this was done previously, you may use the steps as before or follow the steps as below:

For your information: In this instance, my merging `dev` branch did not seem to authenticate and work when I merge it into the main from changing my files in my Github repo thus not completing the job in Jenkins. 

Must do:

Step 1 

- Open Jenkins and Create a new item/job called `name-ci` (ruhal-ci) and choose freestyle project
- Set description e.g `Building and automating my pipeline`
- Discard old builds and set max builds to 3
- Choose Github project (HTTPs link), on the main branch and repo with the app folder

Step 2 

- SCM to, on main branch repo, SSH key link for the repository URL, and thus create a new key which you may do within the .ssh folder following this link, 
- Choose `SSH Username` and paste the new key and click add in credentials. 
- Make sure the name of the private key insights that is shown in your terminal matches and the key is perfectly copy and pasted.

If errors persist with the key e.g `permission denied` please follow the commands below:

`sudo su - jenkins`

`eval `ssh-agent -s``

`ssh -T git@github.com`

- Exit Jenkins terminal `exit`

Step 3

- Within the `branch Specifier` change to `dev` instead of main, as we now are creating our `dev` branch to use within GitHub and Jenkins deployment.

FYI - This `dev` branch did not work for my case, so instead I switched back `main` to make it easier when I start deploying the sparta app. 

- Select `GitHub Hook Trigger` which we setup earlier.

Step 4

- Within the `build environment` we choose to `provide Node & npm` which is the `spara-node-app` which we configured through the plugins
- Within the `execute shell` command:

      cp app
      npm install
      npm test
