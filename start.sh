#!/bin/bash

echo "1) Install prod server"
echo "2) Install replica server"
echo "3) Configur dump to dir dumps"

scripts="scripts"

read VALUE

case $VALUE in

1)
    echo "Install prod server"
    sudo bash prod.sh
    echo "Success!"
    ;;

2)
    echo "Install replica server"
    sudo bash replica.sh
    echo "Success!"
    ;;

3)
    echo "Create dir script and copy dump.sh"
    if [ -d "$scripts" ]; then
        echo "Dir ${scripts} exist"
    else
        ###  Control will jump here if $DIR does NOT exists ###
        echo "Dir ${scripts} not exist!"
        echo "Create dir dumps!"
        sudo mkdir scripts
        sudo cp dump.sh /scripts/
        ls -la
        exit 1
    fi

    echo "Success!"
    ;;

    *)
    echo "Incorect value"
    ;;
esac
