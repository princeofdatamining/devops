# see more versions, visit https://github.com/docker/compose/releases
if [ x"" == x"$1" ]; then
  VERSION="1.22.0"
else
  VERSION="$1"
fi

sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
