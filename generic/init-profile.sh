WORKDIR=$(realpath ~)
if [ ! -z "$1" ]; then
    WORKDIR="$(realpath "$1")"
fi
echo "WORKDIR = '$WORKDIR'"


if [ "$SHELL" = "/bin/zsh" ]; then
    PROFILE=~/.zshrc
else
    PROFILE=~/.bash_profile
fi
echo "append '$PROFILE' ..."


cat <<EOF >> $PROFILE

export PYENV_ROOT="$WORKDIR/pyenv"
export PATH="\$PYENV_ROOT/bin:\$PATH"
[ -s "\$PYENV_ROOT/bin/pyenv" ] && eval "\$(pyenv init -)"
[ -s "\$PYENV_ROOT/plugins/pyenv-virtualenv/bin/pyenv-virtualenv-init" ] && eval "\$(pyenv virtualenv-init -)"

export NVM_DIR="$WORKDIR/nvm"
[ -s "\$NVM_DIR/nvm.sh" ] && \. "\$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "\$NVM_DIR/bash_completion" ] && \. "\$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export rvm_path="$WORKDIR/rvm"
export PATH="\$rvm_path/bin:\$PATH"
[ -f "\$rvm_path/scripts/rvm" ] && source "\$rvm_path/scripts/rvm"

if [ -f "/usr/libexec/java_home" ]; then
    # export JAVA_HOME=\$(/usr/libexec/java_home -v1.8)
    export JAVA_HOME=\$(/usr/libexec/java_home)
    export JAVA_DIR="$WORKDIR/java"
    export PATH="\$PATH:\$JAVA_DIR/apache-maven-3.5.0/bin"
fi
EOF
