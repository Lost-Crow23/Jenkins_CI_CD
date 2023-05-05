 <h1>Jenkins CI/CD Setup</h1>

We use Jenkins for the CI and CD through our Github to launch it on the AWS AMI cloud instance deployment

<h2>Pre-requisites</h2>

- Clone the app Folder onto the Github Repo file so the code is within the folder and repo

<h2>Jenkins Deployment</h2>

<h3>Webhook Creation</h3>

<h4>Step 1</h4>

- Create a webhook to make an endpoint towards Jenkins.
- Make sure to create the webhook to which the App Folder is in.
- Settings, Webhooks, Add webhooks.

<img width="1199" alt="Step 1 webhook 3:05" src="https://user-images.githubusercontent.com/126012715/236292987-3003391f-61a7-4518-af69-d5ab717a33d2.png">

The webhook allows external services to be notified when certain changes happen. 

- Copy the home Jenkins URL link to connect github to Jenkins. 
- Only click push only

- Add webhook

<h4>Step 2</h4> 

- Go back to the first Jenkins CI (name-ci) created and add a build trigger to initiate the automation.
- `Github hook trigger for GitScm polling`.

<img width="961" alt="Step 2 add hook trigger" src="https://user-images.githubusercontent.com/126012715/236293150-6df1cd56-1f06-4e48-998f-ac31da64c213.png">

- We use our previous ssh link repo and the ssh private key since we are using the same AMI instance.

Should be now finished in the name-ci (first build project)

<h4>Step 3</h4>

Testing the webhook within our local host towards jenkins

You can either, 
- Go on Github folder and edit one of your readme.md file, e.g. #Webhook test

<img width="1264" alt="Webhook automation Step 3 1" src="https://user-images.githubusercontent.com/126012715/236300341-6389e7a0-2d1b-4331-996c-1bcf7a5ec474.png">

- Go on Gitbash terminal, and `cd` to the current repo where the app folder is in so `Jenkins_CI_CD.`

and 

- Git pull, to pull the changes from the changes we made earlier.
- Sudo nano <Readme.md file> to make the changes to test it
- `git add .` then `git commit -m ""`
- `git push` so you would be able to push it on Github

Should pop up as a new build deployment within Jenkins.

<img width="769" alt="step 3 webhook jenkins deploy" src="https://user-images.githubusercontent.com/126012715/236293275-b14d302b-ff97-4c39-a012-561cd10cb907.png">

<h3>Creating our new branch within Jenkins</h3>

<h4>Step 1</h4>

- Create a new job/item called `name-ci-test` (in our case we named it name-ci-merge)
- Copy our old job/item as a template since it would have similar settings ruhal-ci(name-CI)
- Create dev branch on local host e.g 

`git branch dev` to make a new branch

`git checkout dev` to switch to the dev branch

- Push to github which should trigger the job/item
- Test passed, merge code back to main branch

`git merge main`

- Now switch back to the target branch `main` by `git checkout main`
- `git merge dev` we merges the dev branch into the main branch 
- `git add .` then `git commit -m "" then `git push origin main` and it should push the new merged branch.
- Test this by checking Jenkins, which should show a new build being deployed. 

<img width="1246" alt="step 4 Dev Branch (3:04:23)" src="https://user-images.githubusercontent.com/126012715/236293707-35b9674c-9d97-4365-bc41-8b315495d899.png">

Should now show the updated code and the readme file on your Github automatically. 

<h3>Automating the merge </h3>

<h4>Step 1</h4>

- Go on Jenkins and create a new job `name-ci-test-dev` , copy template from name-ci-test (ruhal-ci-merge)

<h4>Step 2</h4>

- Edit Source code management and edit additional behaviours 

This allows our merging to the main branch, easier.

Diagram 

<h4>Step 3</h4>

- `post build actions` we select git publisher and select as below. 
- This helps if the build succeeds if it doesn't it would not push and an error will pop up.

<img width="956" alt="Step 5 Dev branch SCM" src="https://user-images.githubusercontent.com/126012715/236301820-d5a6e147-be8c-4215-bc3c-1016776d0d98.png">

<h4>Step 4</h4>

- Go to name-ci-merge (test) job
- Edit and add a `add post-build actions`, this will merge our dev branch if it is only successful to this test merge stage. 
- Click Save

<img width="941" alt="Step 7 post build with build other projects" src="https://user-images.githubusercontent.com/126012715/236301866-f40c1624-8503-4d9b-a378-312dd6844266.png">

<h4>Step 5</h4>

- On gitbash terminal, we edit once again `sudo nano <readme file>` and do the following commands, `git add .` , `git commit -m ""` , `git push origin dev`, As this will push any changes we have made in our dev branch to the main branch if successful. 

<h4>Step 6</h4>

- It should deploy it on name-ci-merge (test), thus updating it on the dev branch and as we edited the post build-actions.
- Should trigger `dev` branch `name-ci-merge-dev`, merging the `dev` into the `main` branch

<h4>Final Step</h4>

- Check the working order of the changes by navigating between the GitHub repo's branches, changes that were made within the `dev` branch should have been pushed and added to the `main` branch.

<img width="1264" alt="Step 8 Merging from dev to main" src="https://user-images.githubusercontent.com/126012715/236301957-4ec98bf3-797e-4672-96e6-5e8091d0fa2a.png">

<h3>Creating a third iteration Job to push code to production</h3>

<h4>Step 1</h4>

Lanching our AWS AMI to configure the sparta app through the use of our AWS to get it running on the browser

- Launch our previous AMI's that was created which should the file/code for the sparta app included.

<h4>Step 2</h4>

- Configure the Security group 

<img width="1053" alt="Step 1 SGs sparta app" src="https://user-images.githubusercontent.com/126012715/236302415-4bacbcd8-fa71-4cda-b02e-6e746fe70f9c.png">

- Launch the instance

<h4>Step 3</h4>

- Create a new job called `name-ci-deploy`, (`ruhal-ci-deploy`) to deploy our sparta app 

<img width="949" alt="Step 1 Deploy" src="https://user-images.githubusercontent.com/126012715/236302287-6f21f593-e618-41d8-ba69-ed60b7f617c3.png">

- Edit description as desired e.g `Building a ci to deploy everything to aws ec2`
- Discard old builds, github project as before

<h4>Step 4</h4>

- `office 365 connector` , restrict where this project can be run `sparta-ubuntu-node` as before

<h4>Step 5</h4>

- Add `git` within the SCM as below, so your ssh link from your repo then `add` if key does not exist, which should do from before, and copy and paste the ssh key within the `add credentials` 
- Make sure it is within the `main` branch

<h4>Step 6</h4>

- Under `Build triggers` tick the `Github hook trigger` and add an ssh agent which is already created for us `tech221_aws_key`

<img width="945" alt="step 2 build environment" src="https://user-images.githubusercontent.com/126012715/236302872-ce5a4e68-f4a0-427a-9eb0-045bd90d52cd.png">

<h4>Step 7</h4>

- To Automate this we have to `execute shell` script within `add build step` the commands are as below.

       scp -v -r -o StrictHostKeyChecking=no app/ ubuntu@<my-ip>:/home/ubuntu/
       ssh -A -o StrictHostKeyChecking=no ubuntu@<my-ip> <<EOF
       cd app
       pm2 kill
       sudo npm install pm2 -g
       nohup node app.js > /dev/null 2>&1 &
       
 <img width="934" alt="step 3 Execute shell " src="https://user-images.githubusercontent.com/126012715/236302908-629a27da-4821-4102-93d9-4c9ef5ed0d09.png">

- Click save
  
<h4>Final step</h4>
  
- `Build now` to test the deployment of the app, and type `:3000` at the end as we are used this port to check if the app has deployed.

<h4>Extra Step</h4>
  
- Edit the `app` file within your IDE (Vscode) and edit the sparta message to your desired message. 
- Do the usual commands to update and push the repo to the Github
  
<img width="1439" alt="Third Job, Sparta app edited " src="https://user-images.githubusercontent.com/126012715/236290805-f694b650-bdeb-424e-b658-1cf8e22e6d13.png">


  
 

