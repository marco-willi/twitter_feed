#!/bin/bash

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
apt-cache policy docker-ce
sudo apt-get install -y docker-ce
sudo systemctl status docker

# get application code
sudo rm -r ~/twitter_feed/
git clone https://github.com/marco-willi/twitter_feed.git ~/twitter_feed
chmod +x ~/twitter_feed/code/run.sh

# build docker
cd ~/twitter_feed
sudo docker build -t twitter_feed .
# sudo docker run -it -v ~/twitter_feed/code:/code twitter_feed:latest /code/run.sh

# run
# cd /code
# python main.py
