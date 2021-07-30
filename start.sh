#!/bin/bash

echo "1) Install prod server"
echo "2) Install replica server"
echo "3) Configur dump to dir dumps"


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
    echo "Dumps"
    
    echo "Success!"
    ;;


*)
    echo "Incorect value"
    ;;
esac