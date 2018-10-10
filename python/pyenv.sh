PYENV="$(realpath ~/.pyenv)"

for arg in "$@"; do
    if [ "$arg" == "yum" ]; then
        yum install -y \
            git wget curl make gcc patch \
            openssl-devel readline-devel sqlite sqlite-devel \
            zlib-devel bzip2 bzip2-devel
    elif [ "$arg" == "apt" ]; then
        apt-get install -y \
            git wget curl make gcc \
            openssl libssl-dev libreadline-dev libsqlite3-dev \
            zlib1g-dev libbz2-dev \
            build-essential llvm libncurses5-dev xz-utils
    elif [ "$arg" == "brew" ]; then
        brew install openssl readline sqlite3 zlib xz
        xcode-select --install
    else
        PYENV="$(realpath "$arg")"
    fi
done


[ -z "$PYENV_ROOT" ] && cat <<EOF >> ~/.bash_profile
export PYENV_ROOT="$PYENV"
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOF

export PYENV_ROOT="$PYENV"

# https://github.com/pyenv/pyenv-installer
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
