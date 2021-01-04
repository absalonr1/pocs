# data gw linux instaler 5.8
https://objectstorage.us-ashburn-1.oraclecloud.com/p/aHllXuwJbt9hTsVztN57upcj3V6tKV5uZgOG96maX9K677oD2v5lAJ2YiPMI-ymM/n/idlhjo6dp3bd/b/bucket-oac-data-gw/o/data-gw-linux-5.8


Oracle/Middleware/Oracle_Home/domain/bin/startJetty.sh
Oracle/Middleware/Oracle_Home/domain/bin/status.sh
ssh RDG-HOST Oracle/Middleware/Silent_Home/domain/bin/startJetty.sh
ssh RDG-HOST Oracle/Middleware/Silent_Home/domain/bin/status.sh
admin
Admin123

sudo iptables -nL
sudo iptables -I INPUT 5 -p tcp --dport 8080 -j ACCEPT
sudo iptables-save

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --reload

# Todo : load balancer


# DB System


(DESCRIPTION=(CONNECT_TIMEOUT=5)(TRANSPORT_CONNECT_TIMEOUT=3)(RETRY_COUNT=3)(ADDRESS_LIST=(LOAD_BALANCE=on)(ADDRESS=(PROTOCOL=TCP)(HOST=10.1.0.3)(PORT=1521)))(CONNECT_DATA=(SERVICE_NAME=DB0104_iad2hz.myhostname)))

system/WElcome12_#

jdbc:oracle:thin:@//10.1.0.3:1521/DB0104_iad2hz.myhostname

jdbc:oracle:thin:@//129.213.43.140:1521/ORCL


jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=10.1.0.3)(PORT=1521))(CONNECT_DATA=(DB0104_iad2hz.myhostname)))
jdbc:oracle:thin:@(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=10.1.0.3)(PORT=1521))(CONNECT_DATA=(DB0104_iad2hz.myhostname)))

129.213.43.140

# Windows bastion

Clave windows opc/WELcome12345678_#


# ....................
alter session set "_ORACLE_SCRIPT"=true;
create user aopazo identified by WElcome12_#;

grant connect to aopazo;
grant resource to aopazo;
create tablespace P1;
alter user aopazo default tablespace P1;
alter user aopazo quota 10m on P1;

alter user system identified by WElcome12_#;


# .........................


[opc@RDG-HOST Oracle_Home]$ pwd
/home/opc/Oracle/Middleware/Oracle_Home


./domain/jettybase/etc/realm.properties
./domain/jettybase/resources/jetty-logging.properties
./domain/jettybase/obiee_rdc_agent.properties
./domain/config/rdc.properties
./domain/tmp/obiee/WEB-INF/classes/cartridges.properties
./domain/tmp/obiee/WEB-INF/classes/obiee_javads.properties
./domain/tmp/obiee/WEB-INF/classes/obiee_rdc.properties
./domain/tmp/obiee/WEB-INF/classes/rdcv2.properties
./domain/tmp/obiee/WEB-INF/classes/serviceprocessor.properties
./domain/tmp/obiee/WEB-INF/classes/log4j2.properties
./domain/tmp/essbase/META-INF/maven/com.oracle.essbase/essbase/pom.properties
./jetty/demo-base/etc/login.properties
./jetty/demo-base/etc/realm.properties
./jetty/etc/spnego.properties
./jetty/etc/jdbcRealm.properties
./jetty/resources/log4j.properties



DB
10.1.0.3

Bastion WIN
129.213.60.182
10.1.1.7


 
RDG
10.1.0.4