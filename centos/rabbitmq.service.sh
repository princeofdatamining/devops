# https://www.rabbitmq.com/install-rpm.html

# https://packagecloud.io/rabbitmq/erlang/install#bash-rpm
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash

# https://packagecloud.io/rabbitmq/rabbitmq-server/install#bash-rpm
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash

yum install -y rabbitmq-server

systemctl enable rabbitmq-server
# systemctl restart rabbitmq-server
