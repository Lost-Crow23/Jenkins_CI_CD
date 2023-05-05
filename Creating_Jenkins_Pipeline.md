 <h1>Jenkins Pipeline</h1>

Here we create a completely new pipeline for our jenkins from installing jenkins from scratch from our ec2's and deploying the sparta app through our own Jenkin's account through the use of creating jobs.

Before we get started we need to know what CI/CD is.

Continuous integration (CI) is a DevOps practice in which team members regularly commit their code changes to the version control repository, 
after which automated builds and tests are run. Continuous delivery (CD) is a series of practices where code changes are automatically built, tested
deployed to production.

![diagram jenkins](https://user-images.githubusercontent.com/126012715/236406800-1223672b-f5ca-407c-a0a9-9aab077c97ef.png)

<h2>Creating an AWS Instance</h2>

<h3>Step 1</h3>

- Create a name e.g `name-tech221-master-jenkins`
- Choose Ubuntu 18.04
- Make sure to click `t2.medium` as using micro, might overload the server and the pipeline, so using medium gives us enough CPU utilisation and space 
to work around 
- Key/pair tech221 and now we create out SG's which will create access ports connections from our local host to Jenkins 
- Launch the instance

<img width="1155" alt="Step 1 SG instance" src="https://user-images.githubusercontent.com/126012715/236359401-5047f746-9b8a-4527-af19-aebb5fcc06a2.png">

<h3>Step 2</h3>

<h2>Create a Agent Node</h2>

All dependencies to run the app folder has been installed within this instance.

- Create name e.g `name-ci-app-new-v1` and choose ubuntu 18.04.
- Make sure to click `t2.micro` as our server would not overload and CPU would remain standard.
- Key/pair `tech221` and now we create our SGs with the given access ports as below.

<img width="1156" alt="Step 2 CI app new v1 SGs" src="https://user-images.githubusercontent.com/126012715/236359621-9a08ba3e-f64e-4297-817d-c0e737f6662d.png">

<h2>Installing Jenkins on Ubuntu 18.04</h2>

<h3>Step 1</h3>

- On git bash terminal, make sure to `.ssh` onto your instance of the master e.g `name-tech221-master-jenkins`.
- Make sure you are logged in as a user with `admin` or be able to use `sudo`.
- Then run the following commands.

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

<h3>Step 2</h3>

- To Setup the jenkin's installation, open your browser and type your IP address from your AWS EC2 instance e.g `http://54.154.206.39:8080/` making sure
we add `:8080` at the end for Jenkin's.

![Unlock Jenkins Step 2 ](https://user-images.githubusercontent.com/126012715/236359670-ec3520b0-f717-4ca3-950c-98ffb3125e3d.png)

- From our previous commands we were given a password, to access jenkin's, so we just copy and paste the password e.g `0eefc4f9f74d4896a05bef8e294504d9` and click `continue`. 

<h3>Step 3</h3>

- A setup wizard will ask you whether you want to install suggested plugins or specific plugins. We chose `install suggested plugins`

![Step 4 Install plugins](https://user-images.githubusercontent.com/126012715/236361221-e3a84234-0659-4c9f-b0db-4d404280534e.png)

<h3>Step 4</h3> 

- Now we setup our Admin `Username` and `password` for jenkins account.

<img width="997" alt="Step 6 Create first admin master node jenkins" src="https://user-images.githubusercontent.com/126012715/236361235-8aed2a13-ff21-4a9f-895a-c8238ca8b29c.png">

<h3>Step 5</h3>

- Once completed, this page will set the URL for your Jenkins instance which will be your primary URL.

<h3>Step 6</h3>

- Jenkins should be ready to use.

<img width="1000" alt="Step 7 Jenkins is ready master node" src="https://user-images.githubusercontent.com/126012715/236361245-a6d59e26-55e1-4276-9bf8-fbe24b3f31dc.png">

<h3>Installing Plugins</h3>

These plugins are required to move further to use our Jenkins with our instance and create jobs to launch our sparta app.

- On Jenkins, go to `dashboard` and choose `manage jenkins`

<img width="1090" alt="Step 8 Manage Jenkins" src="https://user-images.githubusercontent.com/126012715/236361278-5f9169e2-1be0-491a-a848-627ee33b4c65.png">

- Click `Available Plugins`
- And install the following plugins either with `restart` or `without restart`.

      NodeJS Plugin
      Amazon EC2 Plugin
      Office 365 Connector
      SSH Agent Plugin
      GitHub plugin # Should have been automatically installed
      
<h3>Step 7</h3>

- Make changes through `global tool configuration`
- Scroll down to the `nodejs` plugin we had installed and edit the plugin to name (sparta-node-app), version `NodeJS 16`, then edit on 

`Global npm packages to install` and we paste `sudo npm install pm2 -g`

- Click save

<img width="1155" alt="Step 9 Nodejs Step " src="https://user-images.githubusercontent.com/126012715/236361310-4c9d5477-ba8a-4f6f-879c-75bc7bb9f00a.png">

<h3>Final Step</h3>

When build Job, it should automatically automate and be sucessfull without the use of creating a `dev` branch nor the AMI instance (`deploy job`)

<h2>Create a new pipeline</h2>

As this was done previously, you may use the steps as before or follow the steps as below:

For your information: In this instance, my merging `dev` branch did not seem to authenticate and work when I merge it into the main from changing my files in my Github repo thus not completing the job in Jenkins. 

<strong>Must do</strong>:

<h3>Step 1</h3>

- Open Jenkins and Create a new item/job called `name-ci` (ruhal-ci) and choose freestyle project
- Set description e.g `Building and automating my pipeline`
- Discard old builds and set max builds to 3
- Choose Github project (HTTPs link), on the main branch and repo with the app folder

<h3>Step 2</h3>

- SCM to, on main branch repo, SSH key link for the repository URL, and thus create a new key which you may do within the .ssh folder following this link [Git, GitHub and SSH keys](https://github.com/Lost-Crow23/tech221_aws#git-github-and-ssh-keys)

- Choose `SSH Username` and paste the new key and click add in credentials. 
- Make sure the name of the private key insights that is shown in your terminal matches and the key is perfectly copy and pasted.

If errors persist with the key e.g `permission denied` please follow the commands below:

#let's you access the jenkins server within git bash terminal with admin privileges
`sudo su - jenkins`

#Launches the ssh agent and lets the current terminal use the ssh keys without manually to do it
`eval `ssh-agent -s``

#Used to link the ssh connection from the local host to your github 
`ssh -T git@github.com`

- Exit Jenkins terminal `exit`

<h3>Step 3</h3>

- Within the `branch Specifier` change to `dev` instead of main, as we now are creating our `dev` branch to use within GitHub and Jenkins deployment.

FYI - This `dev` branch did not work for my case, so instead I switched back `main` to make it easier when I start deploying the sparta app. 

- Select `GitHub Hook Trigger` which we setup earlier.

- Create a webhook in the `settings` of the GitHub repo in `main` branch, `delete` the previous webhooks used and create a new one.
- Copy the Jenkins URL IP address but add `/github-webhook/` to initiate the webhook.
- Add the `pub key` as you would copy and paste it from the git bash terminal.
- Choose `application/json` and save.

<img width="806" alt="Step 10 New webhook pipeline" src="https://user-images.githubusercontent.com/126012715/236361402-f6d0b2fa-37b5-4221-be3d-275106c54c66.png">

- Make sure to `deploy key` within the repo to link the Jenkins server to the public key.
- This is your `pub key` from your `.ssh key-gen` use `cat name-github-key` to access the 

<h3>Step 4</h3>

- Within the `build environment` we choose to `provide Node & npm` which is the `spata-node-app` which we configured through the plugins
- Within the `execute shell` command:

      cp app
      npm install
      npm test

<h2>Creating the merge(test) Job </h2>

FYI - This has not been created due to not being able to use the `dev` branch to sync it to my main. But it has been successfully done in my previous readme.md file as the pipeline was clear and working. You may want to try and have a look at this [Jenkins CI/CD Setup](https://github.com/Lost-Crow23/Jenkins_CI_CD/blob/main/Jenkins_Setup.md#jenkins-cicd-setup) if you do progress onto this stage. This is used to edit our `app` folder thus merging it with the `main` thus deploying it after through our ` AWS app Instance`.

<h2>Creating to deploy our Sparta App</h2>

<h3>Step 1</h3>

- Open Jenkins and Create a new item/job called `name-ci-deploy` (ruhal-ci-deploy) and choose freestyle project
- Set description e.g `Deploying the app onto AWS instance`
- Discard old builds and set max builds to 3
- Choose Github project (HTTPs link), on the main branch and repo with the app folder
      
<h3>Step 2</h3>

- SCM to, on main branch repo, SSH key link for the repository URL, and thus choose git and insert the private key which you may do within the .ssh folder or the previous created credentials.

<h3>Step 3</h3>

- Within the `branch Specifier` change to `main`, as we now are initiating the merge from the main to our deployment.
- Choose `provide Node & npm` choosing `sparta-node-app`
- From plugin `ssh agent` we create our own `ssh username`, secret key, `cat tech221.pem` command in Git bash terminal within the `.ssh` folder to give the secret key and add too credentials.

<img width="974" alt="ruhal-aws-key deploy" src="https://user-images.githubusercontent.com/126012715/236361423-91970579-81fe-4d6e-a771-fb2e9d22ed01.png">

<h3>Step 4</h3>

- `Execute Shell` as below:

      scp -v -r -o StrictHostKeyChecking=no app/ ubuntu@<my-ip>:/home/ubuntu/
      ssh -A -o StrictHostKeyChecking=no ubuntu@<my-ip> <<EOF
      cd app
      pm2 kill
      sudo npm install pm2 -g
      nohup node app.js > /dev/null 2>&1 &
      
- Paste the IP from the `name-ci-app-new-v1` which is the AMI App instance

<img width="935" alt="step 12 Execute Shell file Last script deploy" src="https://user-images.githubusercontent.com/126012715/236361461-3a70a10a-0ff8-45c5-8adf-fe57bdb9215e.png">

<h3>Step 5</h3>

- Go back to Jenkins and see if the `build-jobs` are running and working, which be should displayed as a green tick or a blue circle.

<img width="1433" alt="Step 13 Check to see if jenkins job working" src="https://user-images.githubusercontent.com/126012715/236361453-d8581838-9698-43ce-a735-131f08615744.png">

<h3>Final Iteration</h3>

- Choose the first job e.g `name-ci` and edit the configuration
- Edit `post-build actions` and `build other projects`
- We edit and choose our `name-ci-deploy`

FYI - This should have been the `test` instead it is the `merge` job but since it did not work in this instance we are skipping to the deploying stage, IN REAL TIME PROJECTS, THIS IS FATAL AND YOU CANNOT DO THIS, but due to time purposes, we are just authenticating the deployment if it works through our own jenkins.

- Select `Trigger only if build is stable`

<img width="993" alt="Final step deploy post build actions" src="https://user-images.githubusercontent.com/126012715/236361500-659164c0-dd08-435e-9664-860bc2c4fadd.png">


- You may make changes to the repository then use the commands to push the changes ideally into the `dev` branch, but in this case, it has been directly pushed to the `main` branch within GitHub.
- You may now paste the `name-ci-app-new-v1` IP into the browser with the `:3000` and should work.

<img width="1357" alt="Final Deployment Jenkins pipeline" src="https://user-images.githubusercontent.com/126012715/236361516-36704757-663a-4de3-963a-8a038859344f.png">

