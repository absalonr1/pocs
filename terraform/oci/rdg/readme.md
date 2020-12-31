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

# RD URL 
http://129.213.78.239:8080/obiee/config.jsp

193.122.157.237
10.1.1.2
"10.1.1.0/24"

10.1.0.2
"10.1.0.0/24"
