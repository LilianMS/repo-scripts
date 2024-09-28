# Infraestrutura como Código
**Projeto - Infraestrutura como Código:**
_Script de Criação de Estrutura de Usuários, Diretórios e Permissões_
>Curso de Linux pela DIO - Prof. [@denilsonbonatti](https://github.com/denilsonbonatti)

Realizei alterações no projeto proposto, pois estou fazendo um tempo depois da criação do curso e tive problemas para usar -crypt, ao que parece pela versão o Openssl.
Pesquisando cheguei a solução com a instalação do pacote whois.
Isso tudo porque a proposta do projeto inclui criar usuários com configarções prévias como a criação de uma senha com a flag -p para adduser que só aceita se a senha for encripitada.
Na versão anterior teríamos a linha

```encrypted_password=$(openssl passwd -crypt "$password")```

e agora

```encrypted_password=$(mkpasswd -m sha-512 "$password")```

Assim temos:

```sudo apt-get install -y whois```: Instala o pacote whois que contém o comando mkpasswd.

```create_user()```: Função que cria um usuário com senha criptografada.

```mkpasswd -m sha-512 "$password"```: Gera a senha criptografada usando o algoritmo SHA-512.

```useradd "$username" -m -s /bin/bash -p "$encrypted_password" -G "$group"```: Cria o usuário com a senha criptografada e adiciona ao grupo especificado.

##

>Em ```mkpasswd -m sha-512```
>
>```mkpasswd```: faz parte do pacote whois e é usado para gerar senhas criptografadas.
>
>```-m sha-512```: especifica o algoritmo de criptografia a ser usado.
>
>O ***sha-512*** é um algoritmo de hash seguro que gera uma senha criptografada robusta.

##

O código traz também uma função para gerar os usuários com as congigurações pedidas, assim trabalha com variáveis para organizar melhor e reduzir algumas repetições:

```
create_user() {
    username=$1
    password=$2
    group=$3
    encrypted_password=$(mkpasswd -m sha-512 "$password")
    useradd "$username" -m -s /bin/bash -p "$encrypted_password" -G "$group"
}
```
