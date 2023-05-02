Setup of Jenkins CI/CD pipeline using GitHub

Diagram

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



