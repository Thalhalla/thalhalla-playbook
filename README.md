# Thalhalla-Playbook

On a debian machine, have Ansible Install Zsh, Oh-my-zsh Ultimate vim distro (spf13), synergy, git, kdiff3, exuberant-ctags, and more

WARNING: this is a total mess its like ellis island except for forlorn shellscripts that setup an env

I need to clean it up, but instead I keep bolting on more!

If you find things broken please open an issue in the queue

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

### ArchLinux

There is support for ArchLinux in here, but it is experimental of note

```
make initarch
```

```
make arch
```

should get you equivalent packages to the debian side of things YMMV

### BlackArch

There is also a script to install the black arch repos for security related tasks

```
make blackarch
```

### Video and Audio

there are a few recipes for video and audio that can be incanted on their own, they are included in the overall debian and arch recipes though

### Docs

#### Keychain

[Keychain](http://www.funtoo.org/Keychain) is executed at login by either `.zshrc` or `.bash_profile`

#### Spacevim

``
make spacevim
```

Now deprecated is the old
[SPF13](http://vim.spf13.com/) is the ultimate Distribution of VIM read more on their [site](http://vim.spf13.com/)

#### Zsh

[ZSH](http://zsh.sourceforge.net/Intro/) is still a bourne shell derivative, I still write all my scripts in bash, but interactively I greatly prefer ZSH
try `cd /u/s/d/pass` and then hit `TAB` and watch that expand to `cd /usr/share/doc/passwd` and you may begin to see why I like zsh

#### Go 

Go is installed and ~/.golang is set as GOPATH

#### Ruby

Ruby 2.1 is installed via rvm and then bundler is installed to take care of the Gemfile within which all gems will be installed

#### Nodejs

Yarn and gatsby are intalled through npm along with a few other goodies

###### Historical

Adapted from [this](https://github.com/lmacken/ansible-hacker-playbook) originally, but it was yum, not apt, so I made my own

For more related errata look here:
[joshuacox.github.io](http://joshuacox.github.io/)
