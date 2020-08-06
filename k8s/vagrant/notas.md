user/pass: vagrant/vagrant

# Estando en el directorio:
# -h ayuda
vagrant init <box name>
vagrant up

# https://www.vagrantup.com/docs/multi-machine
vagrant up {box name}

vagrant reload
vagrant halt
# fuerza el apagado
vagrant halt -f
vagrant destroy
vagrant suspend
vagrant status
vagrant ssh
vagrant ssh {box name}

vagrant package
vagrant box list
vagrant box remove {name}
vagrant box add --name {box name} {box file}

# identificar interfaz de la wifi
iw dev