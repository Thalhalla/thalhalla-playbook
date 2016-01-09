# Thalhalla-Playbook


On a debian machine, have Ansible Install Zsh, Oh-my-zsh Ultimate vim distro (spf13), synergy, git, kdiff3, exuberant-ctags, and more

  Installs
  - build-essential
  - git
  - wget
  - curl
  - zsh
  - oh-my-zsh [The Ultimate Zsh Distribution](https://github.com/robbyrussell/oh-my-zsh)
  - vim-athena
  - exuberant-ctags
  - spf13-vim, [The Ultimate Vim Distribution](http://vim.spf13.com)
  - python
  - python-pip
  - Ansible
  - docker
  - docker-py
  - nodejs-devl and npm
  - ruby-dev
  - byobu
  - rvm and then ruby from rvm
  - kdiff3
  - tree
  - htop
  - synergy
  - keychain
  - awesome
  - nload
  - iftop
  - iptraf
  - nethogs
  - bmon
  - slurm
  - tcptrack
  - vnstat
  - bwm-ng
  - cbm
  - speedometer
  - netdiag
  - ifstat
  - dstat
  - collectl
  - nmap
  - sshfs
  - ack-grep
  - net-tools
  - dnsutils
  - chromium
  - iceweasel
  - icedove
  - lynx-cur
  - links2
  - w3m
  - w3m-img
  - irssi
  - mutt
  - tree
  - ssh-askpass-gnome
  - autokey
  - finch
  - pidgin
  - pidgin-otr
  - terminator
  - yakuake

## Usage

#### Oneliner

you'll need sudo for this

```
curl https://raw.githubusercontent.com/Thalhalla/thalhalla-playbook/master/bootstrapThalhalla.sh | bash
```

#### Ansible Playbook

That will install the full recipe to localhost, which is a good place to start. If you'd like you can create your own hosts file or symlink one here in this directory and then

```
make full
```

and all hosts you specify should be given the full treatment

Adapted from [this](https://github.com/lmacken/ansible-hacker-playbook) originally, but it was yum, not apt, so I made my own

For more related errata look here:
[joshuacox.github.io](http://joshuacox.github.io/)
