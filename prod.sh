#!/bin/bash
echo "Update ...."
sudo apt update
echo "Finished update "

echo "Upgrade ... "
sudo apt upgrade
echo "Finished upgrade"

echo "Install mc ..."
sudo apt install mc
echo "Finished i mc "

echo "Install my sql server ..."
sudo apt install mysql-server
echo "Finished i mysql server "

echo "Restart mysql"
sudo service mysql restart
sudo sleep 3

echo "Updating mysql configs in /etc/mysql/mysql.conf.d/mysqld.cnf"
sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
echo "Updated mysql bind address in /etc/mysql/mysql.conf.d/mysqld.cnf to 0.0.0.0 to allow external connect"

echo "# log_bin/"
sudo sed '/log_bin/s/^#//' -i /etc/mysql/mysql.conf.d/mysqld.cnf
echo "log_bin/"

echo "# server-id"
sudo sed '/server-id/s/^#//' -i /etc/mysql/mysql.conf.d/mysqld.cnf
echo "server-id"

# echo "server-id = 1"
# sudo sed -i 's/server-id.*/server-id = 1/' /etc/mysql/mysql.conf.d/mysqld.cnf
# echo "server-id = 1"


echo "Stop mysql"
sudo service mysql stop
sleep 3

echo "Start mysql"
sudo service mysql start
sleep 3

echo "Restart mysql"
sudo service mysql restart
sleep 3

echo "Setting up ip tables ..............................................................."

sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP
sudo iptables -P FORWARD DROP


# закрываем все соединения
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT

# разрешаем трафик loopback, нужен обязательно
sudo iptables -A INPUT -p all -m state —state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p all -m state —state NEW,ESTABLISHED,RELATED -j ACCEPT

# разрешаем инициированные программами, системой и их дочерние соединения.
sudo iptables -A INPUT -m state —state INVALID -j DROP
sudo iptables -A FORWARD -m state —state INVALID -j DROP


## далее команды чтобы открыть порт Linux:
sudo iptables -A INPUT -i eth0 -p tcp —dport 22 -j ACCEPT
sudo iptables -A INPUT -i eth0 -p udp —dport 22 -j ACCEPT


# открываем порты для посещения сайтов
# iptables -A INPUT -i eth0 -p tcp —dport «номер нужного входящего порта» -j ACCEPT
# iptables -A OUTPUT -i eth0 -p tcp —dport «номер нужного исходящего порта» -j ACCEPT

sudo iptables -A INPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT
sudo iptables -A OUTPUT -i eth0 -p tcp -m tcp --dport 3306 -j ACCEPT

echo "Finished set up ip tables _______________________________________________________"


echo "Install net tool ..."
sudo apt install net-tools
echo "Finished i net tool"
echo ""
mysql -V


# sudo mysql -u root -p
# CREATE USER 'repl'@'ip replica' IDENTIFIED BY 'secret';
# GRANT REPLICATION SLAVE ON *.* TO 'repl'@'ip';
# SHOW MASTERSTATUS \G
# CHANGE REPLICATION SOURCE TO SOURCE_HOST='ip replica', SORCE_LOG_FILE='from replica', SOURCE_LOG_POS= , SOURCE_SSL=1;
# START REPLICA USER='some user' PASSWORD='';
# SHOW REPLICA STATUS \G


