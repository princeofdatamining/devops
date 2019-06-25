#!/usr/bin/env bash

# CNICG 国家平台节点系统自动部署脚本结合 yum
# 请用 sudo 账户运行该脚本
# 确保 目标服务器设置 可以联网
# 创建用户：sudo useradd -G wheel USERNAME
# 配置密码：sudo passwd USERNAME


YUM_URI=; EPEL_URI=;
set_aliyun() {
    echo "use aliyun repo ..."
    SOURCE=http://mirrors.aliyun.com/repo
    YUM_URI=${SOURCE}/Centos-7.repo
    EPEL_URI=${SOURCE}/epel-7.repo
}
set_tencent() {
    echo "use tencent repo ..."
    SOURCE=http://mirrors.cloud.tencent.com/repo
    YUM_URI=${SOURCE}/centos7_base.repo
    EPEL_URI=${SOURCE}/epel-7.repo
}
set_aliyun # 默认


yum_set() {
    echo "try yum_set ..."
    sudo yum install -y wget

    [ -f /etc/yum.repos.d/CentOS-Base.repo ] && \
    sudo mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    [ -f /etc/yum.repos.d/epel.repo ] && \
    sudo mv /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.backup

    sudo wget -O /etc/yum.repos.d/CentOS-Base.repo ${YUM_URI}
    sudo wget -O /etc/yum.repos.d/epel.repo ${EPEL_URI}

    sudo yum clean all
    sudo yum makecache
    # sudo yum repolist
    sudo yum install -y curl lrzsz git
    sudo yum install -y gcc make
}


cnicg_init() {
    echo "try cnicg_init ..."
    [ ! -d /cnicg ] && sudo mkdir /cnicg && sudo chown $(whoami):$(whoami) /cnicg
    mkdir -p /cnicg/{app,download,projs,logs} /cnicg/conf/{nginx,supervisor}/conf.d /cnicg/conf/nginx/optimize
    touch /cnicg/conf/nginx/optimize/{ssl,gzip,favicon,robots}.conf
}


nginx_yum_repo() {
cat <<'EOF' | sudo tee /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF
}

nginx_install() {
    echo "try nginx_install ..."
    sudo yum install -y nginx
    # append /etc/nginx/nginx.conf
    # include /cnicg/conf/nginx/conf.d/*.conf
    sudo systemctl enable nginx.service
    sudo systemctl start nginx.service
}


mariadb_install() {
    echo "try mariadb_install ..."
    sudo yum install -y mariadb mariadb-server mariadb-devel
    sudo systemctl start mariadb
    sudo systemctl enable mariadb
    # initialize root password
    # mysql_secure_installation
    # GRANT ALL PRIVILEGES ON `iot`.* TO  iot'@'localhost'
}


mongodb_install() {
    echo "try mongodb_install ..."
    sudo yum install -y mongodb mongodb-server mongodb-test
    sudo systemctl start mongod
    sudo systemctl enable mongod
}


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


supervisor_install() {
    echo "try supervisor_install ..."
    sudo yum install -y supervisor
    # append /etc/supervisord.conf
    # files = supervisord.d/*.ini
    # ==>
    # files = ... /cnicg/conf/supervisor/conf.d/*.conf
    [ -d /cnicg/conf/supervisor/conf.d ] && \
    sudo sed -i "s/^files.*/files = \/cnicg\/conf\/supervisor\/conf.d\/*.conf/" /etc/supervisord.conf
    sudo systemctl stop supervisord
    sudo systemctl start supervisord
    sudo systemctl enable supervisord
}


pip_install() {
    echo "try pip_install ..."
    mkdir -p ~/.pip
    echo "[global]" > ~/.pip/pip.conf
    echo "cache-dir = /tmp/cache-pip" >> ~/.pip/pip.conf
    echo "index-url = http://mirrors.aliyun.com/pypi/simple/" >> ~/.pip/pip.conf
    echo "trusted-host = mirrors.aliyun.com" >> ~/.pip/pip.conf
    curl -fSL https://bootstrap.pypa.io/get-pip.py | sudo ${1:-python2}
    # 如果出现错误：“sudo: pip3：找不到命令”
    # 改用： sudo `which pip3` ...
}


python3_install() {
    echo "try python3_install ..."
    sudo yum install -y python36 python36-devel #python36-setuptools
    pip_install python36
}


pyenv_install() {
    echo "try pyenv_install ..."
    if [ "$(uname -s)" = "Darwin" ]; then
        brew install openssl readline sqlite3 xz zlib
        xcode-select --install
    elif which yum > /dev/null; then
        sudo yum install -y \
            git wget curl make gcc patch \
            openssl-devel readline-devel sqlite sqlite-devel \
            zlib-devel bzip2 bzip2-devel libffi-devel mariadb-devel
    elif which apt-get > /dev/null; then
        sudo apt-get install -y \
            git wget curl make gcc \
            openssl libssl-dev libreadline-dev libsqlite3-dev \
            zlib1g-dev libbz2-dev \
            build-essential llvm libncurses5-dev xz-utils
    fi
    # https://github.com/pyenv/pyenv-installer
    if which pyenv > /dev/null; then
        echo "pyenv already: `which pyenv`"
    else
        curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | $SHELL
    fi
    #
    if [ -z ${PYENV_ROOT} ]; then
        mv ~/.pyenv /cnicg/app/pyenv
        echo 'export PYENV_ROOT=/cnicg/app/pyenv' | tee -a ~/.bashrc
        echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' | tee -a ~/.bashrc
        echo '[ -f ${PYENV_ROOT}/bin/pyenv ] && eval "$(pyenv init -)"' | tee -a ~/.bashrc
        echo '[ -f ${PYENV_ROOT}/bin/pyenv ] && eval "$(pyenv virtualenv-init -)"' | tee -a ~/.bashrc
        source ~/.bashrc
    else
        [ -f ${PYENV_ROOT}/bin/pyenv ] && eval "$(pyenv init -)"
        [ -f ${PYENV_ROOT}/bin/pyenv ] && eval "$(pyenv virtualenv-init -)"
    fi
}


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


while true; do
  case "$1" in
    --yum ) yum_set; shift ;;
    --yum-aliyun ) set_aliyun; yum_set; shift ;;
    --yum-tencent ) set_tencent; yum_set; shift ;;
    --cnicg ) cnicg_init; shift ;;
    --nginx-repo ) nginx_yum_repo; shift ;;
    --nginx ) nginx_install; shift ;;
    --mariadb ) mariadb_install; shift ;;
    --mongodb ) mongodb_install; shift ;;
    --rabbitmq ) rabbitmq_install; shift ;;
    --supervisor ) supervisor_install; shift ;;
    --pip2 ) pip_install; shift ;;
    --python3 ) python3_install; shift ;;
    --pyenv ) pyenv_install; shift ;;
    --nvm ) nvm_install; shift ;;
    -- ) shift; echo "-- $@"; break ;;
    * ) break ;;
  esac
done

echo "All of the base app were installed succesfull"
