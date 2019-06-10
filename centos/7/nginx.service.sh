sudo cat <<'EOF' > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum install -y nginx
sudo systemctl enable nginx
