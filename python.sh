#!/bin/sh
if [[ -d $(pyenv root)/plugins/pyenv-virtualenv ]]; then
  echo 'already cloned skipping'
else
  git clone \
    https://github.com/pyenv/pyenv-virtualenv.git \
    $(pyenv root)/plugins/pyenv-virtualenv
fi
