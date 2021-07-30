#!/bin/sh

CURRENTDATE=$(date +"%Y-%m-%d %T")
path='dumps'

temp1=$(echo $CURRENTDATE | tr "-" "_")
datafile=$(echo $temp1 | tr ":" "_")


if [ -d "$path" ]; then
    echo "Dir ${path} exist"
else
    ###  Control will jump here if $DIR does NOT exists ###
    echo "Dir ${path} not exist!"
    echo "Create dir dumps!"
    sudo mkdir dumps
    exit 1
fi

UP=$(/etc/init.d/mysql status | grep running | grep -v not | wc -l)
if [ "$UP" -ne 1 ]; then
    echo "MySQL is down."
    echo "Running mysql server ..."
    service mysql start
    echo "MySQL is UP."

else
    echo "All is well."
fi

mysqldump --login-path=local moodle >$path/_"$datafile".sql
