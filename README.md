
## In this repository scripts for installing mysql server, create production server, create replication, export dump db

    Run bash script start.sh


### Configuration for prod

    sudo mysql -u root -p
    CREATE USER 'repl'@'ip replica' IDENTIFIED BY 'secret';
    GRANT REPLICATION SLAVE ON *.* TO 'repl'@'ip replica';
    SHOW MASTER STATUS\G
    CHANGE REPLICATION SOURCE TO SOURCE_HOST='ip replica', SOURCE_LOG_FILE='from replica', SOURCE_LOG_POS= , SOURCE_SSL=1;
    START REPLICA USER='some user' PASSWORD='';
    SHOW REPLICA STATUS \G


### Configuration for replica


    sudo mysql -u root -p
    SHOW MASTER STATUS\G
    CHANGE REPLICATION SOURCE TO SOURCE_HOST='', SOURCE_LOG_FILE='', SOURCE_LOG_POS= , SOURCE_SSL=1;
    START REPLICA USER='some user' PASSWORD='';
    CREATE USER 'repl'@'ip prod' IDENTIFIED BY 'secret';
    GRANT REPLICATION SLAVE ON *.* TO 'repl'@'ip prod';
    SHOW MASTER STATUS\G