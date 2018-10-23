# https://github.com/pyenv/pyenv/wiki/Common-build-problems
VERSION=$1
CFLAGS=""
LDFLAGS=""
shift

for arg in $@; do
    CFLAGS="$CFLAGS -I$(brew --prefix $arg)/include"
    LDFLAGS="$LDFLAGS -L$(brew --prefix $arg)/lib"
done

echo $CFLAGS
echo $LDFLAGS

CFLAGS="$CFLAGS" \
LDFLAGS="$LDFLAGS" \
pyenv install $VERSION

# ./osx/install-pyenv-python.sh x.y.z zlib
# ./osx/install-pyenv-python.sh x.y.z zlib sqlite
# ./osx/install-pyenv-python.sh x.y.z zlib sqlite openssl

# zipimport.ZipImportError: can't decompress data; zlib not available
# make: *** [install] Error 1
# LDFLAGS="-L$(brew --prefix zlib)/lib" CPPFLAGS="-I$(brew --prefix zlib)/include" pyenv install $*


# WARNING: The Python sqlite3 extension was not compiled. Missing the SQLite3 lib?
# LDFLAGS="-L$(brew --prefix sqlite)/lib" CPPFLAGS="-I$(brew --prefix sqlite)/include" pyenv install $*


# missing ssl
# LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" pyenv install $*
