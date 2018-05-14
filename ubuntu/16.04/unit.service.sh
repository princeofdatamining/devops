curl https://nginx.org/keys/nginx_signing.key?_ga=2.189204075.1500106418.1526308681-1689708186.1526308681 | apt-key add -

cat <<EOF > /etc/apt/sources.list.d/unit.list
deb https://packages.nginx.org/unit/ubuntu/ xenial unit
deb-src https://packages.nginx.org/unit/ubuntu/ xenial unit
EOF

apt-get update
apt-get install unit unit-php unit-python2.7 unit-python3.5 unit-go unit-perl unit-ruby
