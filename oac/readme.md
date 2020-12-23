# vm bastion 
ssh -i ssh-key-2020-12-23.key opc@132.145.185.243

# scp
scp -i ssh-key-2020-12-23.key ssh-key-2020-12-23.key opc@132.145.185.243:/home/opc

 # ProxyJump
---

# VM privada
ssh -i ssh-key-2020-12-23.key opc@10.0.1.2
