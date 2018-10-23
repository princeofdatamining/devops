WORKDIR=$(realpath ~)
if [ ! -z "$1" ]; then
    WORKDIR="$(realpath "$1")"
fi
echo "WORKDIR = '$WORKDIR'"


if [ "$SHELL" = "/bin/zsh" ]
    PROFILE=~/.zshrc
else
    PROFILE=~/.bash_profile
fi
echo "append '$PROFILE' ..."


cat <<'EOF' >> $PROFILE

export PYENV_ROOT="$WORKDIR/pyenv"
export PATH="\$PATH:\$PYENV_ROOT/bin"
if which pyenv > /dev/null; then eval "\$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "\$(pyenv virtualenv-init -)"; fi

export NVM_DIR="$WORKDIR/nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export RVM_DIR="$WORKDIR/rvm"
export PATH="\$PATH:\$RVM_DIR/bin"
[ -f "\$RVM_DIR/scripts/rvm" ] && source "\$RVM_DIR/scripts/rvm"

if [ -f "/usr/libexec/java_home" ]; then
    export JAVA_HOME=\$(/usr/libexec/java_home)
export JAVA_DIR="$WORKDIR/java"
export PATH="\$PATH:\$JAVA_DIR/apache-maven-3.5.0/bin"
EOF
