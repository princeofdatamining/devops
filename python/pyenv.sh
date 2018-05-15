PYENV="$(realpath ~/.pyenv)"
MNG="yum"

for arg in "$@"; do
    if [ "$arg" == "yum" ]; then
        MNG=$arg
    elif [ "$arg" == "apt" ]; then
        MNG=$arg
    elif [ "$arg" == "brew" ]; then
        MNG=$arg
    else
        PYENV="$(realpath "$arg")"
    fi
done

if [ "$MNG" == "yum" ]; then
    yum install -y \
        wget curl make gcc patch \
        openssl-devel readline-devel sqlite sqlite-devel \
        zlib-devel bzip2 bzip2-devel
else
    echo "$MNG install ..."
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
