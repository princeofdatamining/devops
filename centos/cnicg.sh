#!/usr/bin/env bash

# CNICG 国家平台节点系统自动部署脚本结合 yum
# 请用 sudo 账户运行该脚本
# 确保 目标服务器设置 可以联网
# 创建用户：sudo useradd -G wheel USERNAME
# 配置密码：sudo passwd USERNAME

yum_set(){
    echo "try yum_set ..."
    sudo yum install -y wget

    [ -f /etc/yum.repos.d/CentOS-Base.repo ] && \
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    [ -f /etc/yum.repos.d/epel.repo ] && \
    sudo mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup

    sudo wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.cloud.tencent.com/repo/centos7_base.repo && \
    sudo wget -O /etc/yum.repos.d/epel.repo http://mirrors.cloud.tencent.com/repo/epel-7.repo && \

    sudo yum clean all && \
    sudo yum makecache
    # sudo yum repolist
    sudo yum install -y curl lrzsz git
}
[[ $@ =~ "yum" ]] && yum_set


cnicg_init() {
    echo "try cnicg_init ..."
    [ ! -d /cnicg ] && sudo mkdir /cnicg && sudo chown $(whoami):$(whoami) /cnicg
    mkdir -p /cnicg/{app,download,projs,logs} /cnicg/conf/{nginx,supervisor}/conf.d
}
[[ $@ =~ "cnicg" ]] && cnicg_init


nginx_install(){
    echo "try nginx_install ..."
    sudo yum install nginx -y
    # append /etc/nginx/nginx.conf
    # include /cnicg/conf/nginx/conf.d/*.conf

    sudo systemctl enable nginx.service
    sudo systemctl start nginx.service
}
[[ $@ =~ "nginx" ]] && nginx_install


supervisor_install() {
    echo "try supervisor_install ..."
    sudo yum -y install supervisor
    # append /etc/supervisord.conf
    # include /cnicg/conf/supervisor/conf.d/*.conf

    sudo systemctl start supervisord
    sudo systemctl enable supervisord
}
[[ $@ =~ "supervisor" ]] && supervisor_install


python3_install() {
    echo "try python3_install ..."

    mkdir -p ~/.pip
    echo "[global]" > ~/.pip/pip.conf
    echo "cache-dir = /tmp/cache-pip" >> ~/.pip/pip.conf
    echo "index-url = http://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf
    echo "trusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf

    sudo yum -y install python36 python36-devel #python36-setuptools

    # install pip3
    curl -fSL https://bootstrap.pypa.io/get-pip.py | sudo python36
    echo "alias sudo='sudo env PATH=\$PATH'" | tee -a ~/.bashrc; source ~/.bashrc
    #sudo pip3 install uwsgi
}
[[ $@ =~ "python3" ]] && python3_install


mongodb_install() {
    echo "try mongodb_install ..."
    sudo yum -y install mongodb mongodb-server mongodb-test
    sudo systemctl start mongod
    sudo systemctl enable mongod
}
[[ $@ =~ "mongodb" ]] && mongodb_install


mariadb_install() {
    echo "try mariadb_install ..."
    sudo yum -y install mariadb mariadb-server mariadb-devel
    sudo systemctl start mariadb
    sudo systemctl enable mariadb

    # initialize root password
    # mysql_secure_installation
    # GRANT ALL PRIVILEGES ON `iot`.* TO  iot'@'localhost'
}
[[ $@ =~ "mariadb" ]] && mariadb_install


rabbitmq_install() {
    echo "try rabbitmq_install ..."
    sudo yum install -y rabbitmq-server
    sudo systemctl enable rabbitmq-server
    sudo systemctl start rabbitmq-server
    # sudo systemctl status rabbitmq-server

    # 配置 virtual host
    #sudo rabbitmqctl add_vhost /?

    # 配置帐号、密码
    #sudo rabbitmqctl add_user ? ?

    # 分配权限
    #sudo rabbitmqctl set_permissions -p /? ? ".*" ".*" ".*"
}
[[ $@ =~ "rabbitmq" ]] && rabbitmq_install


nvm_clone() {
    git -c advice.detachedHead=false clone \
        https://github.com/creationix/nvm.git \
        -b v0.33.11 \
        --depth=1 \
        "$1"
}

nvm_install() {
    echo "try nvm_install ..."
    echo "registry=https://registry.npm.taobao.org" > ~/.npmrc
    NVM_DIR="/cnicg/app/nvm"
    mkdir -p "$NVM_DIR"
    nvm_clone "$NVM_DIR"
    chmod +x "$NVM_DIR/nvm.sh"
    echo "export NVM_DIR=\"$NVM_DIR\"" >> ~/.bash_profile
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bash_profile
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bash_profile
    source ~/.bash_profile
    # nvm ls-remote --lts | grep -i "latest"
    nvm install v10.15.3; npm i -g yarn
}
[[ $@ =~ "nvm" ]] && nvm_install


echo "All of the base app were installed succesfull"
