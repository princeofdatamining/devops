curl -L -o /usr/local/bin/assign-ip http://do.co/assign-ip
chmod +x /usr/local/bin/assign-ip

mkdir /usr/lib/ocf/resource.d/digitalocean
curl -L -o /usr/lib/ocf/resource.d/digitalocean/floatip http://do.co/ocf-floatip
chmod +x /usr/lib/ocf/resource.d/digitalocean/floatip
