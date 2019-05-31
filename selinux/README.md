# SELinux


## 查看

`getenforce`


## 关闭(临时)

`sudo setenforce 0`


## 配置(需要重启)

`sudo sed -i "s/^SELINUX=.*/SELINUX=permissive/" /etc/selinux/config`
