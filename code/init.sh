#!/bin/bash

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker

# install docker compose
sudo curl -o /usr/local/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.16.1/docker-compose-$(uname -s)-$(uname -m)"
sudo chmod +x /usr/local/bin/docker-compose
docker-compose -v

# get application code
sudo rm -r ~/twitter_feed/
git clone https://github.com/marco-willi/twitter_feed.git ~/twitter_feed
chmod +x ~/twitter_feed/code/run.sh

# run docker compose
sudo mkdir /db
cd ~/twitter_feed
sudo docker-compose up --build

# build docker
# cd ~/twitter_feed
# sudo docker build -t twitter_feed .
# sudo docker run -it -v ~/twitter_feed/code:/code twitter_feed:latest /code/run.sh

# run
# cd /code
# python main.py
