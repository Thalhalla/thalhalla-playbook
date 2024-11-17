
all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make initdebian     - acquire sudo (and all groups) for your local user and initialize apt with a fast mirror
	@echo ""   2. make debian         - run thalhalla playbook locally on a debian machine ensure init has been ran first
	@echo ""   3. make initarch       - acquire sudo (and all groups) for your local user and initialize pacman with a fast mirror
	@echo ""   3. make arch           - run thalhalla playbook on arch

init: initdebian

thalhalla: thalhalladeb

initdebian: USERNAME initsudo

debian: localbootstrap begin thalhalladeb nodejs thoth dev ruby bundle videodeb audiodeb rclone smxi

#deprecated-arch: USERNAME localbootstraparch beginarch thalhallaarch azagthoth dev rubyarch bundle videoarch audioarch nvm rclone tmuxinator
# arch: initarch localbootstraparch azagthoth beginarch thalhallaarch spacevim zsh rubyarch nvm rclone miniconda
arch: initarch localbootstraparch azagthoth beginarch thalhallaarch spacevim zsh nvm rclone miniconda

dev: spacevim zsh

test: rm testxenial

testjessie: buildjessie 
	RELEASE=jessie make rundocker

testxenial: buildxenial 
	RELEASE=xenial make rundocker

testyakkety: buildyakkety 
	RELEASE=yakkety make rundocker

testzesty: buildzesty
	RELEASE=zesty make rundocker

xenial: localbootstrap begin thalhallaxenial nodejs thoth dev ruby bundle rclone tmuxinator

yakkety: localbootstrap begin thalhallayakkety nodejs thoth dev ruby bundle rclone tmuxinator

zesty: localbootstrap begin thalhallazesty nodejs thoth dev ruby bundle rclone tmuxinator

studio: videodeb audiodeb

bundle:
	-@rm -f Gemfile.lock
	sudo gem install bundler
	bundle install

buildjessie:
	RELEASE=jessie make builder

buildxenial:
	RELEASE=xenial make builder

buildyakkety:
	RELEASE=yakkety make builder

buildzesty:
	RELEASE=zesty make builder

builder:
	/usr/bin/time -v docker build -t thalhalla-test-${RELEASE} -f Dockerfile.${RELEASE} .

nvm:
	./nvm.sh

rundocker:
	$(eval TMP := $(shell mktemp -d --suffix=ThalhallaDOCKERTMP))
	chmod 777 $(TMP)
	docker run --name=thalhalla-test \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-d \
	--privileged \
	-t thalhalla-test-${RELEASE}

update: SHELL:=/bin/bash --login
update:
	ansible-playbook -i hosts  update.yml

updatearch:
	./inner.sh
	sudo pacman -Syu --noconfirm reflector archlinux-keyring
	sudo pacman -S --noconfirm base-devel
	-sudo pacman -Rdd --noconfirm vim
	sudo pacman -S --noconfirm gvim
	sudo pacman -S iptables-nft
	./outer.sh

nodejs: SHELL:=/bin/bash --login
nodejs:
	ansible-playbook -i hosts  nodejs.yml

ruby: SHELL:=/bin/bash --login
ruby:
	ansible-playbook -i hosts  ruby.yml

rubyarch:
	bash installrvm.sh
	bash gemInstaller.sh

zsh: SHELL:=/bin/bash --login
zsh:
	./zsh.sh

videodeb: SHELL:=/bin/bash --login
videodeb:
	ansible-playbook -i hosts  videodeb.yml

audiodeb: SHELL:=/bin/bash --login
audiodeb:
	ansible-playbook -i hosts  audiodeb.yml

videoarch: SHELL:=/bin/bash --login
videoarch:
	ansible-playbook -i hosts  videoarch.yml

audioarch: SHELL:=/bin/bash --login
audioarch:
	ansible-playbook -i hosts  audioarch.yml

spf13: SHELL:=/bin/bash --login
spf13:
	ansible-playbook -i hosts  spf13.yml

spacevim:
	curl -sLf https://spacevim.org/install.sh | bash

janus:
	curl -L https://bit.ly/janus-bootstrap | bash
	cp -i vimrc.before ~/.vimrc.before
	cp -i vimrc.after ~/.vimrc.after
	echo 'Janus Documentation |==> https://github.com/carlhuda/janus <==|'
	sleep 1

thalhallaarch: SHELL:=/bin/bash
thalhallaarch:
	$(eval TARGET_LIST := $(shell cat pacman_list | tr '\n' ' '))
	./inner.sh
	sudo powerpill -S --noconfirm $(TARGET_LIST)
	./bauerbillExtras.sh
	./python.sh
	./outer.sh
#	ansible-playbook -i hosts  thalhallaarch.yml

thalhalladeb: SHELL:=/bin/bash --login
thalhalladeb:
	ansible-playbook -i hosts  thalhalladeb.yml

thalhallaxenial: SHELL:=/bin/bash --login
thalhallaxenial:
	ansible-playbook -i hosts  thalhallaxenial.yml

thalhallayakkety: SHELL:=/bin/bash --login
thalhallayakkety:
	ansible-playbook -i hosts  thalhallayakkety.yml

thoth: SHELL:=/bin/bash --login
thoth:
	ansible-playbook -i hosts  thoth.yml

azagthoth: SHELL:=/bin/bash --login
azagthoth:
	bash bootstrapThothArch.sh
	#ansible-playbook -i hosts  azagthoth.yml

prep: build localbootstrap

build:
	sudo apt-get install -y ansible git build-essential aptitude
	date -I>build

bootstrap: SHELL:=/bin/bash --login
bootstrap:
	ansible-playbook -i hosts  bootstrapAnsible.yml

localbootstraparch:
	sudo pacman -S --noconfirm ansible
	date -I>localbootstraparch

localbootstrap: SHELL:=/bin/bash --login
localbootstrap:
	sudo bash bootstrapansible.sh
	bash installansible.sh
	date -I>localbootstrap

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

clean:
	-rm localbootstrap

initsudo:
	$(eval USERNAME := $(shell cat USERNAME))
	$(eval TARGET := $(shell pwd))
	@echo "This script requires root access to grant you sudo!"
	@echo "You will be prompted for the root password."
	@sleep 1
	@echo "$(USERNAME)"
	@echo "$(TARGET)"
	su -c "bash  debinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(USERNAME)"
	@echo "Now log out and log back in to attain sudo status"

initarch: USERNAME initsudoarch

initsudoarch: .initsudoarch

.initsudoarch:
	$(eval USERNAME := $(shell cat USERNAME))
	$(eval TARGET := $(shell pwd))
	@echo "This script requires root access to grant you sudo!"
	@echo "You will be prompted for the root password."
	@sleep 1
	@echo "$(USERNAME)"
	@echo "$(TARGET)"
	su -c "bash  $(TARGET)/archinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(USERNAME)"
	date -I >> .initsudoarch
	@echo "Now log out and log back in to attain sudo status"
	exit 1

smxi:
	sudo bash installsmxi.sh

netselect:
	sudo bash netselect.sh

begin: USERNAME update

beginarch: USERNAME updatearch xyne

blackarch:
	./blackArch.sh

yaourt:
	./inner.sh
	sudo cp pacman.conf /etc/
	sudo cp yaourtrc /etc/
	sudo pacman -Sy --noconfirm yaourt
	yaourt -S aurvote
	./outer.sh

rclone:
	$(eval TMP := $(shell mktemp -d --suffix=ThalhallaDOCKERTMP))
	chmod 777 $(TMP)
	cd $(TMP) ;\
	curl -O \
	https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
	unzip rclone-current-linux-amd64.zip ;\
	sudo cp rclone-*/rclone /usr/local/bin/ ;\
	sudo chown root:root /usr/local/bin/rclone ;\
	sudo chmod 755 /usr/local/bin/rclone ;\
	sudo mkdir -p /usr/local/share/man/man1 ;\
	sudo cp rclone-*/rclone.1 /usr/local/share/man/man1/
	sudo mandb
	@echo "rclone config <--- to configure RCLONE"

tmuxinator:
	mkdir -p ~/.bin
	cd ~/.bin && \
	wget -cq https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.bash && \
	wget -cq https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh && \
	wget -cq https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.fish

kill:
	-@docker kill `cat cid`

rm-image:
	-@docker rm `cat cid`
	-@rm cid

rm: kill rm-image

enter:
	docker exec -i -t `cat cid` /bin/bash

logs:
	docker logs -f `cat cid`

USERNAME:
	whoami > USERNAME

xyne:
	sudo cp -a xyne-mirrorlist /etc/pacman.d/
	sudo cp -a pacman.conf /etc/
	./inner.sh
	sudo pacman -Sy
	sudo pacman -S --noconfirm powerpill bauerbill
	./outer.sh

miniconda:
	bash miniconda-installer
