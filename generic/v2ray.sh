MODE="$1"
V2="$2"
V3="$3"
V4="$4"

# $0 server PORT USER
# $0 relay HOST PORT USER
if [ "$MODE" == "relay" ]; then
    HOST="$V2"
    PORT="$V3"
    USER="$V4"
else
    PORT="$V2"
    USER="$V3"
fi

sudo yum install -y wget unzip

# Server or Relay
curl -sL https://install.direct/go.sh | sudo $SHELL

[ ! -f "/etc/v2ray/default.json" ] && \
sudo cp /etc/v2ray/config.json /etc/v2ray/default.json

# Extracting V2Ray package to /tmp/v2ray.
# PORT:32890
# UUID:b97272a2-c629-4efa-9875-56b6f142bf7d
# Created symlink from /etc/systemd/system/multi-user.target.wants/v2ray.service to /etc/systemd/system/v2ray.service.
# V2Ray v3.48 is installed.

# /usr/bin/v2ray/v2ray：V2Ray 程序；
# /usr/bin/v2ray/v2ctl：V2Ray 工具；
# /etc/v2ray/config.json：配置文件；
# /usr/bin/v2ray/geoip.dat：IP 数据文件
# /usr/bin/v2ray/geosite.dat：域名数据文件
# /etc/systemd/system/v2ray.service


[ ! "$MODE" = "relay" ] && \
sudo cat <<EOF > /etc/v2ray/config.json
{
  "inbound": {
    "port": $PORT,
    "protocol": "vmess",
    "settings": {
      "clients": [
        {
          "id": "$USER",
          "level": 1,
          "alterId": 64
        }
      ]
    }
  },
  "outbound": {
    "protocol": "freedom",
    "settings": {}
  },
  "outboundDetour": [
    {
      "protocol": "blackhole",
      "settings": {},
      "tag": "blocked"
    }
  ],
  "routing": {
    "strategy": "rules",
    "settings": {
      "rules": [
        {
          "type": "field",
          "ip": ["geoip:private"],
          "outboundTag": "blocked"
        }
      ]
    }
  }
}
EOF


# 内网中继服务，提供 socks(1080)、http(1088)服务
[ "$MODE" = "relay" ] && \
sudo cat <<EOF > /etc/v2ray/config.json
{
  "dns" : {
    "servers" : [
      "8.8.8.8"
    ]
  },
  "inbound": {
    "listen": "0.0.0.0", // 本地/内网地址
    "port": 1080,
    "protocol": "socks",
    "settings": {
      "udp": true
    }
  },
  "inboundDetour" : [
    {
      "listen" : "0.0.0.0", // 本地/内网地址
      "port" : 1088,
      "protocol" : "http",
      "allocate" : {
        "strategy" : "always",
        "refresh" : 5,
        "concurrency" : 3
      },
      "tag" : "httpDetour",
      "domainOverride" : [
        "http",
        "tls"
      ],
      "streamSettings" : {

      },
      "settings" : {
        "timeout" : 0
      }
    }
  ],
  "outbound": {
    "protocol": "vmess",
    "settings": {
      "vnext": [{
        "address": "$HOST", // 服务器地址，请修改为你自己的服务器 ip 或域名
        "port": $PORT,  // 服务器端口
        "users": [{ "id": "$USER" }]
      }]
    }
  },
  "outboundDetour": [
    {
      "protocol": "freedom",
      "tag": "direct",
      "settings": {}
    }
  ]
}
EOF


# 启动服务
sudo systemctl enable v2ray
sudo systemctl restart v2ray
sudo systemctl status v2ray


# 本地/中继测试
# curl --socks4a 127.0.0.1:1080 -fsSL https://google.com/robots.txt
# curl --proxy http://127.0.0.1:1088 -fsSL https://google.com/robots.txt



# server
# https://github.com/v2ray/v2ray-core/releases/download/v3.48/v2ray-linux-64.zip
# https://www.v2ray.com/download/Core_v3.47/v2ray-linux-64.zip
# mkdir v2ray
# unzip v2ray-linux-64.zip -d v2ray/
# cd v2ray



# client
# https://www.v2ray.com/download/V2RayX_v1.3.0/V2RayX.app.zip
# https://www.v2ray.com/download/V2RayN_2.16/v2rayN.exe
# https://www.v2ray.com/download/V2RayNG_0.5.9/app-x86_64-release.apk
# https://www.v2ray.com/download/BifrostV_v0.5.8/BifrostV_v0.5.8.apk
# https://www.v2ray.com/download/Actinium_0.10.2/app-universal-release_aligned_signed.apk
# https://www.v2ray.com/download/SwitchyOmega_v2.5.20/SwitchyOmega_Chromium.crx
# https://www.v2ray.com/download/SwitchyOmega_v2.5.20/proxy_switchyomega-2.5.20-an%252Bfx.xpi
