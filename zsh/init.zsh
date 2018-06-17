export EDITOR='vim'
export VISUAL='vim'

if [[ `uname` == 'Darwin' ]]
then
  export GOROOT=/usr/local/opt/go/libexec
else
  export GOROOT=/usr/lib/go
fi
export GOPATH=$HOME/Projects/golang

export PYENV_ROOT=$HOME/.pyenv
export N_PREFIX=$HOME/.node

source $HOME/.php-version/php-version.sh && php-version 7.2
source $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh

path=(
  $GOROOT/bin
  $GOPATH/bin
  $PYENV_ROOT/bin
  $N_PREFIX/bin
  $HOME/{bin,.composer/vendor/bin,.local/bin}
  $path
)

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
