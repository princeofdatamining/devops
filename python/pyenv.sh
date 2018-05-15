if [ x"" == x"$1" ]; then
  PYENV="$(realpath ~/.pyenv)"
else
  PYENV="$(realpath "$1")"
fi

cat <<EOF >> ~/.bash_profile
export PYENV_ROOT="$PYENV"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF

export PYENV_ROOT="$PYENV"

# https://github.com/pyenv/pyenv-installer
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

yum install -y \
wget curl make gcc patch \
openssl-devel zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel
