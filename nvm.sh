#!/bin/bash
. lib/loader.bash
release_target=dubnium

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# lib/liner.bash
ZSHRC_LOCATION=~/.zshrc
BASH_PROFILE_LOCATION=~/.bash_profile
LINE_TO_ADD='export NVM_DIR="$HOME/.nvm"'
liner
LINE_TO_ADD='[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm'
liner
LINE_TO_ADD='[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
liner

nvm install lts/$release_target
nvm alias default lts/$release_target
npm i -g gatsby-cli yarn
