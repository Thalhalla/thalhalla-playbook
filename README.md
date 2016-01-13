# Thalhalla-Playbook

On a debian machine, have Ansible Install Zsh, Oh-my-zsh Ultimate vim distro (spf13), synergy, git, kdiff3, exuberant-ctags, and more

## Usage

##### cheat sheet curl method

For this method you will need to have installed sudo and curl already and given yourself the `sudo` group or equivalent privileges, then incant

```
curl https://raw.githubusercontent.com/Thalhalla/thalhalla-playbook/master/bootstrapThalhalla.sh | bash
```

### Manual install

first as root you'll have to install build-essential (or make and friends if you are really into the manual thing)

```
apt-get install -y build-essential
```

now try the init recipe which acquire sudo and all the groups for your user

```
make init
```

Then you can use the debian recipe:

```
make debian
```

### Docs

[SPF13](http://vim.spf13.com/) is the ultimate Distribution of VIM read more on their [site](http://vim.spf13.com/)

[ZSH](http://zsh.sourceforge.net/Intro/) is still a bourne shell derivative, I still write all my scripts in bash, but interactively I greatly prefer ZSH
try `cd /u/s/d/pass` and then hit `TAB` and watch that expand to `cd /usr/share/doc/passwd` and you may begin to see why I like zsh


###### Historical

Adapted from [this](https://github.com/lmacken/ansible-hacker-playbook) originally, but it was yum, not apt, so I made my own

For more related errata look here:
[joshuacox.github.io](http://joshuacox.github.io/)
