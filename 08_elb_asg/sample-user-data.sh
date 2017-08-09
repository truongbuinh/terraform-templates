#!/bin/bash

sudo apt-get udpate
sudo apt-get upgrade -y
sudo apt-get install nginx
sudo systemctl start nginx.service