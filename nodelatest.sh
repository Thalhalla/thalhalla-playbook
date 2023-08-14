#!/bin/bash --login

# install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="/home/`whoami`/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm install lts/hydrogen
nvm use lts/hydrogen
nvm alias default lts/hydrogen
