#!/bin/bash

echo "Install SSH"
sudo apt install openssh-server
echo "Success"
echo "IP"
ip a

echo "Status SSH"
sudo systemctl status ssh