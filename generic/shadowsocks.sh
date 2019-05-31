
# get ss-server to /usr/local/bin/

mkdir -p /etc/shadowsocks && cat <<EOF > /etc/shadowsocks/config.json 
{
    "server": "0.0.0.0",
    "server_port": $1,
    "local_port": 1080,
    "timeout": 60,
    "method": "$2",
    "password": "$3"
}
EOF


cat <<EOF > /etc/systemd/system/shadowsocks.service
[Unit]
Description=Shadowsocks daemon

[Service]
Type=forking
ExecStart=/usr/local/bin/ss-server -c /etc/shadowsocks/config.json
ExecStop=
ExecReload=
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOF


# 启动服务
sudo systemctl enable shadowsocks
sudo systemctl restart shadowsocks
sudo systemctl status shadowsocks
