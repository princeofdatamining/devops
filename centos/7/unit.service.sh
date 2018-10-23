cat <<'EOF' > /etc/yum.repos.d/unit.repo
[unit]
name=unit repo
baseurl=https://packages.nginx.org/unit/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
EOF

yum install -y unit unit-python unit-go unit-php
systemctl enable unit
