#!/bin/bash

# Update the sources list
#sudo apt-get update -y

# upgrade any packages available
#sudo apt-get upgrade -y


## install git
#sudo apt-get install git -y

# install nodejs
#sudo apt-get install python-software-properties -y
#curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
#sudo apt-get install nodejs -y

# install pm2
#sudo npm install pm2 -g

#sudo apt-get install nginx -y

# remove the old file and add our one
#sudo rm /etc/nginx/sites-available/default
#sudo cp /home/ubuntu/sre_jenkins_cicd/environment/app/nginx.default /etc/nginx/sites-available/default

# finally, restart the nginx service so the new config takes hold
#sudo service nginx restart
#sudo service nginx enable
#!/bin/bash

#ssh -A -o StrictHostKeyChecking=no ubuntu@54.74.131.80
#scp -v -r -o StrictHostKeyChecking=no scripts/ ubuntu@34.245.84.134:/home/ubuntu/
#scp -v -o StrictHostKeyChecking=no provision.sh ubuntu@34.245.84.134:/home/ubuntu/
#scp -v -o StrictHostKeyChecking=no default ubuntu@34.245.84.134:/home/ubuntu/




#scp -v -r -o StrictHostKeyChecking=no app ubuntu@54.77.247.111:/home/ubuntu/

#ssh -A -o "StrictHostKeyChecking=no" ubuntu@54.77.247.111 << EOF
# Update and upgrade 
sudo apt-get update -y
sudo apt-get upgrade -y

# Install nginx
sudo apt-get install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

# reverse proxy 
#sudo rm /etc/nginx/sites-available/default
#sudo cp /home/ubuntu/environment/app/nginx.default /etc/nginx/sites-available/default

# Install dependencies
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo apt-get install npm 
sudo npm install pm2 -g
sudo apt-get install python-software-properties -y
sudo apt update -y && sudo apt upgrade -y
cd app
npm install
nohup node app.js > /dev/null 2>&1 &