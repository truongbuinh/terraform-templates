#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y nginx
sudo systemctl start nginx.service