Jenkins CI/CD Setup

We use Jenkins for the CI and CD through our Github to launch it on the AWS AMI cloud instance deployment

Pre-requisites

- Clone the app Folder onto the Github Repo file so the code is within the folder and repo

Jenkins Deployment

Webhook Creation 

Step 1 

- Create a webhook to make an endpoint towards Jenkins.
- Make sure to create the webhook to which the App Folder is in.
- Settings, Webhooks, Add webhooks.

The webhook allows external services to be notified when certain changes happen. 

- Copy the home Jenkins URL link to connect github to Jenkins. 
- Only push 

- Add webhook

Diagram 

Step 2 

- Go back to the first Jenkins CI created and add a build trigger to initiate the automation
- `Github hook trigger for GitScm polling`
- We use our previous ssh link repo and the ssh private key since we are using the same AMI instance

Should be now finished in the name-ci (first build project)

Diagram 

Step 3 

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

Creating our new branch within Jenkins

Step 1 

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

Automating the merge

Step 1 

- Go on Jenkins and create a new job `name-ci-merge-dev` , copy template from name-ci-test (ruhal-ci-merge)

Step 2 

- Edit Source code management and edit additional behaviours 

This allows our merging to the main branch, easier.

Diagram 

Step 3 

- `post build actions` we select git publisher and select as below. 
- This helps if the build succeeds if it doesn't it would not push and an error will pop up.

Diagram

Step 4 

- Go to name-ci-merge (test) job
- Edit and add a `add post-build actions`, this will merge our dev branch if it is only successful to this test merge stage. 
- Click Save

Diagram 

Step 5

- 





