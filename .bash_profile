. $HOME/.bashrc

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/matej/.sdkman"
[[ -s "/home/matej/.sdkman/bin/sdkman-init.sh" ]] && source "/home/matej/.sdkman/bin/sdkman-init.sh"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
