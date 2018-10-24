yum install -y wget make gcc

wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.28-9669-beta/softether-vpnserver-v4.28-9669-beta-2018.09.11-linux-x64-64bit.tar.gz
tar -xzf softether-vpnserver-v4.28-9669-beta-2018.09.11-linux-x64-64bit.tar.gz
cd vpnserver
make i_read_and_agree_the_license_agreement
mkdir -p /app/vpnserver && mv hamcore.se2 vpn* /app/vpnserver/

# # vpnserver command usage:
# #  vpnserver start  - Start the SoftEther VPN Server service.
# #  vpnserver stop   - Stop the SoftEther VPN Server service if the service has been already started.
# $ vpnserver start
# # The SoftEther VPN Server service has been started.

cat <<EOF > /etc/systemd/system/SoftEtherVPNServer.service
[Unit]
Description=SoftEther VPN

[Service]
Type=forking
ExecStart=/app/vpnserver/vpnserver execsvc
ExecStop=
ExecReload=
KillMode=process
Restart=on-failure
RestartSec=42s

[Install]
WantedBy=multi-user.target
EOF


# 启动服务
sudo systemctl enable SoftEtherVPNServer
sudo systemctl restart SoftEtherVPNServer
sudo systemctl status SoftEtherVPNServer
