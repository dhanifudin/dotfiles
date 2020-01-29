export LC_ALL=en_US.UTF-8
export EDITOR='vim'
export VISUAL='vim'

if [[ `uname` == 'Darwin' ]]
then
  export GOROOT=/usr/local/opt/go/libexec
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"
else
  export GOROOT=/usr/lib/go
fi

export GOPATH=$HOME/Projects/golang
export PYENV_ROOT=$HOME/.pyenv
export PHPBREW_RC_ENABLE=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

[[ -e $HOME/.phpbrew/bashrc ]] && source $HOME/.phpbrew/bashrc
[[ -e $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh ]] && source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh

path=(
  $GOROOT/bin
  $GOPATH/bin
  $PYENV_ROOT/bin
  $HOME/{bin,.composer/vendor/bin,.local/bin}
  $path
)

eval "$(thefuck --alias)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
eval "$(fnm env --multi)"
