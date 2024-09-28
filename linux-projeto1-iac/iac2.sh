#!/bin/bash

echo "Creating directories..."

mkdir /public
mkdir /adm
mkdir /ven
mkdir /sec

echo "Creating groups..."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Creating users..."

# Instalar o pacote whois se necessário
sudo apt-get install -y whois

# Função para criar usuário com senha criptografada
create_user() {
    username=$1
    password=$2
    group=$3
    encrypted_password=$(mkpasswd -m sha-512 "$password")
    useradd "$username" -m -s /bin/bash -p "$encrypted_password" -G "$group"
}

create_user carlos Senha123 GRP_ADM
create_user maria Senha123 GRP_ADM
create_user joao Senha123 GRP_ADM

create_user debora Senha123 GRP_VEN
create_user sebastiana Senha123 GRP_VEN
create_user roberto Senha123 GRP_VEN

create_user josefina Senha123 GRP_SEC
create_user amanda Senha123 GRP_SEC
create_user rogerio Senha123 GRP_SEC

echo "Setting directory permissions"

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /public

echo "Done!"
