sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cat <<'EOF' >> ~/.zshrc

export PYENV_ROOT=/work/pyenv
export PATH="$PATH:$PYENV_ROOT/bin"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export NVM_DIR=/work/nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

rvm_path=/work/rvm
export PATH="$PATH:$rvm_path/bin"
[ -f "$rvm_path/scripts/rvm" ] && source "$rvm_path/scripts/rvm"

export JAVA_HOME=$(/usr/libexec/java_home)
java_path=/work/java
export PATH="$PATH:$java_path/apache-maven-3.5.0/bin"
EOF
