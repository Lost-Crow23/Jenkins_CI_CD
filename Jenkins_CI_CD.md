Jenkins CI/CD pipeline using GitHub
#webhook test

![Jenkins Diagram](https://user-images.githubusercontent.com/126012715/235727732-21c4af0e-ae9f-41a0-9fc2-b1cc406340a4.png)

Pre-requisites 

- Download Git and have an account on GitHub
- Have a login for Jenkins
- AWS instance running with node (nginx)
- Git Clone the `app` and `environment` from out previous work

Jenkins Setup

- Login with Jenkins
- Login to your Github

Github Setup 

- Make a new repo with a similar name e.g Jenkins_CI_CD
- Make sure to have relevant node folders such as 'app' and 'environment' in our case , i have cloned this repo `https://github.com/khanmaster/sre_jenkins_cicd`

Clone a repo using the following commands:

`cd` to your folder, then `git clone repo` then go to the cloned copy you just created within your the original repo

`pwd` your current repo folder to get the path

`ls` then `cd` to your folder you just copied e.g `sre_jenkins_cicd`  and use

`cp -r path of repo folder, path of copy` or if you want copy an exact folder `cp -r repo folder path , app`.

- Use `git add . git commit and git push` if not, do

`git pull origin main`

`git merge origin/main`

`git push origin main`


- Should be on your github with the following folders you just have cloned in your repo.

Step 1 

- Follow the link as given and generate a new SSH key within the .ssh folder in the git bash terminal ,[Git, GitHub and SSH keys](https://github.com/Lost-Crow23/tech221_aws#git-github-and-ssh-keys)

Step 2

- Generate a new key and public key, e.g `name-jenkins-key` and `name-jenkins-key.pub`
- `cat name-jenkins-key.pub` to get your public key

Step 3 

- Go on Github repo and click on settings to deploy keys
- `add deploy key`, name your key as familiar name `name-jenkins-key.pub` and paste your public key onto the key section as prompted

<img width="831" alt="Deploy public key on Github" src="https://user-images.githubusercontent.com/126012715/235721921-9b9f6c43-2fce-4fd0-be9a-b3bedd8ce975.png">

Jenkins setup

Step 1

- Create a `item` in jenkins

Step 2 

- Make a name e.g name-CI instead of the below name

<img width="1289" alt="Jenkin, step1 create item" src="https://user-images.githubusercontent.com/126012715/235722867-c9a7433f-fab3-4eb8-a5e4-6c34497a4c5c.png">

- `freestyle project` since our ones simple.

Step 3 

- Description can be as you please but we created one to match what is being done.

<img width="998" alt="SSH key" src="https://user-images.githubusercontent.com/126012715/235724275-42062a59-51f3-4d2c-a626-bc950ec598f8.png">

- Select `Discard old build` and select 3 use of builds so it does not over load Jenkins
- Select `Github project` and select the github repo with the `app` folder within making sure it is the HTTP link

Step 4 

- Make sure to select `Ristrict where it can be run` and select the already made `sparta ubuntu node`

Step 5 

- An error may pop up if no `ssh` key entered as valid as the key
- Select `SSH username with private key`.
- Within Source code management, select Git and on the repo URL, click `add` and enter the `ssh-key` , `cat <private-key>` from the key pair as created before. 
- Add Jenkins to connect the URL from Github

Step 6 

- Make sure to change the branch from `master` to `main`

Step 7 

- Buil environment, select `provide node` 

Step 8 

- Select `build` and `executre shell` and write the following commands to automate the build

<img width="963" alt="execute shell" src="https://user-images.githubusercontent.com/126012715/235727008-c441a7e7-4c44-45a0-b450-7755484c4f7c.png">

Step 9

- `save` and go to the homepage and select `build now` and it should be running

Final Step

- Select `console output` to check if it has passed and we can also see if the test has been successful.


