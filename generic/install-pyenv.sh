# https://github.com/pyenv/pyenv-installer
curl -fsSL https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | $SHELL

## Load pyenv automatically by adding
## the following to ~/.bashrc:
#
# export PYENV_ROOT=/cnicg/app/pyenv
# export PATH="${PYENV_ROOT}/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

if [ "$(uname -s)" = "Darwin" ]; then
    echo "prepare brew and xcode for Mac OS X"
    brew install openssl readline sqlite3 xz zlib
    xcode-select --install
elif which yum > /dev/null; then
    sudo yum install -y \
        git wget curl make gcc patch \
        openssl-devel readline-devel sqlite sqlite-devel \
        zlib-devel bzip2 bzip2-devel libffi-devel
elif which apt-get > /dev/null; then
    sudo apt-get install -y \
        git wget curl make gcc \
        openssl libssl-dev libreadline-dev libsqlite3-dev \
        zlib1g-dev libbz2-dev \
        build-essential llvm libncurses5-dev xz-utils
fi

[ -d ~/.pyenv ] && mv ~/.pyenv /cnicg/app/pyenv
