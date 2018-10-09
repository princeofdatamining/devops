# GateOne note

## Prerequisites

- `python 2.7.x`
- `tornado 4.5.3`

```shell
sudo yum install -y epel-release python2-pip

sudo pip install tornado==4.5.3 gateone==1.2.*
```

## Standalone

```shell
# run server
sudo gateone

# open https://DOMAIN_OR_IP/
```

## Embedded

### change authentication

```shell
# create api key
$ sudo gateone --new_api_key
[I 181009 05:14:50 server:4324] A new API key has been generated: ZWQ0NjM4MzY5Y2U3NDk0NjhlOTYzM2E4NzYzNDNmY2MwZ
[I 181009 05:14:50 server:4326] This key can now be used to embed Gate One into other applications.

# find api keys file
$ sudo find / -name 30api_keys.conf
/etc/gateone/conf.d/30api_keys.conf

# change auth method
# set "auth": "api" in 20authentication.conf

# run server
$ sudo gateone
```

### create application

```shell
# find html resources
$ sudo find / -name gateone.js
/usr/lib/python2.7/site-packages/gateone/static/gateone.js

# change directory
$ cd /usr/lib/python2.7/site-packages/gateone/static/

# OR download it from https://github.com/liftoff/GateOne/blob/master/gateone/static/gateone.js

# create embed application html
cat <<'EOF' > embed.html
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="gateone.js" type="text/javascript"></script>

<title>GateOne</title>
</head>
<body>
<h2>hello gate one</h2>

<div id="gateone_container" style="width: 60em; height: 30em;">
    <div id="gateone"></div>
</div>

<!-- Call GateOne.init() at some point after the page is done loading -->
<script type="text/javascript">
    function initGateOne(auth, go_url, ssh_url) {
        // Initialize Gate One:
        GateOne.init({
            auth: auth, 
            url: go_url, 
            theme: 'solarized',
            autoConnectURL: ssh_url,
            // showToolbar: false,
            goDiv: '#gateone'
        });
    
        GateOne.Net.autoConnect();
    }

    var config = {
        go_url: "",
        ssh_url: ""
    };

    function setUrl(go_url, ssh_url) {
        if (!go_url)
            go_url = config.go_url;
        if (!ssh_url)
            ssh_url = config.ssh_url;
        console.log(go_url, ssh_url);
        return function (auth) {
            return initGateOne(auth, go_url, ssh_url);
        }
    }
</script>

</body>
</html>
EOF

# run server
$ sudo gateone
```

### test

```shell
# auth object script
$ cat <<'EOF' > gateoneutil.py
# -*- coding: utf-8 -*-
""" http://liftoff.github.io/GateOne/Developer/embedding_api_auth.html#python """
import time
import hashlib
import hmac
import json
from django.utils.encoding import force_bytes


DEFAULT_API_VERSION = '1.0'
DEFAULT_SIGNATURE_METHOD = 'HMAC-SHA1'
DEFAULT_DIGESTMOD = hashlib.sha1
SIGNATURE_DIGESTMODS = {
    DEFAULT_SIGNATURE_METHOD: DEFAULT_DIGESTMOD,
}


def create_signature(secret, *parts, **kwargs):
    hash = hmac.new(force_bytes(secret), digestmod=hashlib.sha1)
    for part in parts:
        hash.update(force_bytes(part))
    return hash.hexdigest()


def create_auth_object(api_key, secret, upn, **kwargs):
    timestamp = str(int(time.time() * 1000))
    method = kwargs.get('signature_method') or DEFAULT_SIGNATURE_METHOD
    digestmod = SIGNATURE_DIGESTMODS[method]
    signature = create_signature(secret, api_key, upn, timestamp,
                                 digestmod=digestmod)
    return {
        'api_key': api_key,
        'upn': upn,
        'timestamp': timestamp,
        'signature_method': method,
        'api_version': kwargs.get('api_version') or DEFAULT_API_VERSION,
        'signature': signature,
    }


def _main():
    import sys
    import os
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('api_key')
    parser.add_argument('secret')
    parser.add_argument('upn')
    args = parser.parse_args()
    authobj = create_auth_object(args.api_key, args.secret, args.upn)
    print(json.dumps(authobj, indent=2))

if __name__ == "__main__":
    _main()
EOF

# create new auth obj
$ python gateoneutil.py API_KEY SECRET UPN
{
  "api_key": "...",
  "upn": "yourname",
  "timestamp": "1539070610414",
  "signature_method": "HMAC-SHA1",
  "api_version": "1.0",
  "signature": "..."
}

# open https://DOMAIN_OR_IP/static/embed.html
# open devtools & console
# setUrl("https://DOMAIN_OR_IP/", "ssh://SSH_HOST")(AUTH_OBJ)
```

### nginx configuration

```shell
# change 10server.conf settings
# 	"disable_ssl": true,
#	"https_redirect": false,
#	"port": 80,
#	"url_prefix": "/gateone/"

$ sudo gateone

# nginx server/location block
    location ~ ^/gateone/ {
        proxy_pass http://GATEONE_SERV_IP:GATEONE_SERV_PORT;
        proxy_pass_header Server;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Scheme $scheme;
        proxy_set_header Host $http_host;
        proxy_redirect off;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
```

