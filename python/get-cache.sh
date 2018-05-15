PYTHON="3.6.5"
SOURCE="https://www.python.org/ftp/python"

for arg in "$@"; do
    if [ "$arg" == "mirror" ]; then
        SOURCE="http://mirrors.sohu.com/python"
    elif ! [ x"$arg" == x"" ]; then
        PYTHON=$arg
    fi
done
# 3.6.5
# 3.5.5
# 2.7.15
mkdir -p $PYENV_ROOT/cache
wget -P $PYENV_ROOT/cache $SOURCE/$PYTHON/Python-$PYTHON.tar.xz
