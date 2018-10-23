# wget https://dl.eff.org/certbot-auto
# mv certbot-auto /usr/local/bin/

sudo curl -L https://dl.eff.org/certbot-auto -o /usr/local/bin/certbot-auto
chmod a+x /usr/local/bin/certbot-auto

###########################
### create certificates ###
###########################
# ./certbot-auto certonly --manual \
# --server https://acme-v02.api.letsencrypt.org/directory \
# --preferred-challenges dns \
# -d *.example.com -d *.sub.example.com

###########################
### nginx configuration ###
###########################
# listen 443 ssl;
# ssl_certificate     /etc/letsencrypt/archive/example.com/cert1.pem;
# ssl_certificate_key /etc/letsencrypt/archive/example.com/privkey1.pem;
# ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
# ssl_ciphers         HIGH:!aNULL:!MD5;
