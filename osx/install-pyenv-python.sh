
pyenv install $*


# zipimport.ZipImportError: can't decompress data; zlib not available
# make: *** [install] Error 1
# LDFLAGS="-L$(brew --prefix zlib)/lib" CPPFLAGS="-I$(brew --prefix zlib)/include" pyenv install $*


# WARNING: The Python sqlite3 extension was not compiled. Missing the SQLite3 lib?
# LDFLAGS="-L$(brew --prefix sqlite)/lib" CPPFLAGS="-I$(brew --prefix sqlite)/include" pyenv install $*


# missing ssl
# LDFLAGS="-L$(brew --prefix openssl)/lib" CFLAGS="-I$(brew --prefix openssl)/include" pyenv install $*
