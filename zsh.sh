#!/bin/bash
if [[ -d $HOME/.oh-my-zsh ]]; then
  echo 'zsh already installed skipping'
else
	curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh|sh
	chsh -s /usr/bin/zsh
fi
