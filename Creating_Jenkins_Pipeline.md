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
- Then run the following commands


