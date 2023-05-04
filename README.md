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

The webhook allows external services to be notified when certain changes happen. 

- Copy the home Jenkins URL link to connect github to Jenkins. 
- Only push 

- Add webhook

Diagram 
 
<h4>Step 2</h4> 

- Go back to the first Jenkins CI created and add a build trigger to initiate the automation
- `Github hook trigger for GitScm polling`
- We use our previous ssh link repo and the ssh private key since we are using the same AMI instance

Should be now finished in the name-ci (first build project)

Diagram 

<h4>Step 3</h4>

Testing the webhook within our local host towards jenkins

You can either, 
- Go on Github folder and edit one of your readme.md file, e.g. #Webhook test
- Go on Gitbash terminal, and `cd` to the current repo where the app folder is in so `Jenkins_CI_CD.`
- Git pull, to pull the changes from the changes we made earlier.
- Sudo nano <Readme.md file> to make the changes to test it
- `git add .` then `git commit -m ""`
- `git push` so you would be able to push it on Github

Should pop up as a new build deployment within Jenkins.

Diagram 

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

Should now show the updated code and the readme file on your Github automatically 

<h3>Automating the merge </h3>

<h4>Step 1</h4>

- Go on Jenkins and create a new job `name-ci-merge-dev` , copy template from name-ci-test (ruhal-ci-merge)

<h4>Step 2</h4>

- Edit Source code management and edit additional behaviours 

This allows our merging to the main branch, easier.

Diagram 

<h4>Step 3</h4>

- `post build actions` we select git publisher and select as below. 
- This helps if the build succeeds if it doesn't it would not push and an error will pop up.

Diagram

<h4>Step 4</h4>

- Go to name-ci-merge (test) job
- Edit and add a `add post-build actions`, this will merge our dev branch if it is only successful to this test merge stage. 
- Click Save

Diagram 

<h4>Step 5</h4>

- On gitbash terminal, we edit once again `sudo nano <readme file>` and do the following commands, `git add .` , `git commit -m ""` , `git push origin dev`, As this will push any changes we have made in our dev branch to the main branch if successful. 

<h4>Step 6</h4>

- It should deploy it on name-ci-merge (test), thus updating it on the dev branch and as we edited the post build-actions.
- Should trigger `dev` branch `name-ci-merge-dev`, merging the `dev` into the `main` branch

<h4>Final Step</h4>

- Check the working order of the changes by navigating between the GitHub repo's branches, changes that were made within the `dev` branch should have been pushed and added to the `main` branch.

Diagram 

<h3>Creating a third iteration Job to push code to production  </h3>

<h4>Step 1</h4>

Lanching our AWS AMI to configure the sparta app through the use of our AWS to get it running on the browser

- Launch our previous AMI's that was created which should the file/code for the sparta app included.

<h4>Step 2</h4>

- Configure the Security group 

Diagram 

- Launch the instance

<h4>Step 3</h4>

- Create a new job called `name-ci-deploy`, (`ruhal-ci-deploy`) to deploy our sparta app 

Diagram 

- Edit description as desired e.g `Building a ci to deploy everything to aws ec2`
- Discard old builds, github project as before

<h4>Step 4</h4>

- `office 365 connector` , restrict where this project can be run `sparta-ubuntu-node` as before

<h4>Step 5</h4>

- Add `git` within the SCM as below, so your ssh link from your repo then `add` if key does not exist, which should do from before, and copy and paste the ssh key within the `add credentials` 
- Make sure it is within the `main` branch

<h4>Step 6</h4>

- Under `Build triggers` tick the `Github hook trigger` and add an ssh agent which is already created for us `tech221_aws_key`
 
<h4>Step 7</h4>

- To Automate this we have to `execute shell` script within `add build step` the commands are as below.

       scp -v -r -o StrictHostKeyChecking=no app/ ubuntu@<my-ip>:/home/ubuntu/
       ssh -A -o StrictHostKeyChecking=no ubuntu@<my-ip> <<EOF
       cd app
       sudo npm install pm2 -g
       nohup node app.js > /dev/null 2>&1 &
  
- Click save
  
<h4>Final step</h4>
  
- `Build now` to test the deployment of the app, and type `:3000` at the end as we are used this port to check if the app has deployed.

<h4>Extra Step</h4>
  
- Edit the `app` file within your IDE (Vscode) and edit the sparta message to your desired message. 
  
Diagram 
  


  
 

