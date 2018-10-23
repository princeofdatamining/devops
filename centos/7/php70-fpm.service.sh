cat <<'EOF' > /usr/lib/systemd/system/php-fpm.service
[Unit]
Description=The PHP FastCGI Process Manager
After=syslog.target network.target

[Service]
Type=notify
PIDFile=/var/opt/remi/php70/run/php-fpm/php-fpm.pid
EnvironmentFile=/etc/opt/remi/php70/sysconfig/php-fpm
ExecStart=/opt/remi/php70/root/usr/sbin/php-fpm --nodaemonize
ExecReload=/bin/kill -USR2 $MAINPID
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

systemctl enable php-fpm
systemctl restart php-fpm
systemctl status php-fpm
