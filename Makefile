
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

arch: USERNAME localbootstraparch beginarch thalhallaarch azagthoth dev rubyarch bundle videoarch audioarch nvm rclone tmuxinator

dev: janus zsh

test: rm testxenial

testjessie: buildjessie rundocker

testxenial: buildxenial rundocker

testyakkety: buildyakkety rundocker

xenial: localbootstrap begin thalhalladeb nodejs thoth dev ruby bundle rclone tmuxinator

yakkety: localbootstrap begin thalhallayakkety nodejs thoth dev ruby bundle rclone tmuxinator

studio: videodeb audiodeb

bundle:
	-@rm Gemfile.lock
	bundle install

buildjessie:
	-@cp Dockerfile.jessie Dockerfile
	/usr/bin/time -v docker build -t thalhalla-test .
	-@rm Dockerfile

buildxenial:
	cp Dockerfile.xenial Dockerfile
	/usr/bin/time -v docker build -t thalhalla-test .
	rm Dockerfile

buildyakkety:
	cp Dockerfile.yakkety Dockerfile
	/usr/bin/time -v docker build -t thalhalla-test .
	rm Dockerfile

nvm:
	bash  ./nvm.sh
	echo "nvm install lts/boron"
	echo "nvm alias default lts/boron"

rundocker:
	$(eval TMP := $(shell mktemp -d --suffix=ThalhallaDOCKERTMP))
	chmod 777 $(TMP)
	docker run --name=thalhalla-test \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-d \
	--privileged \
	-t thalhalla-test

update: SHELL:=/bin/bash --login
update:
	ansible-playbook -i hosts  update.yml

updatearch:
	sudo pacman -Syu --noconfirm

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
	ansible-playbook -i hosts  zsh.yml

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

janus:
	curl -L https://bit.ly/janus-bootstrap | bash
	cp -i vimrc.before ~/.vimrc.before
	cp -i vimrc.after ~/.vimrc.after
	echo 'Janus Documentation |==> https://github.com/carlhuda/janus <==|'
	sleep 1

thalhallaarch: SHELL:=/bin/bash --login
thalhallaarch:
	ansible-playbook -i hosts  thalhallaarch.yml

thalhalladeb: SHELL:=/bin/bash --login
thalhalladeb:
	ansible-playbook -i hosts  thalhalladeb.yml

thalhallayakkety: SHELL:=/bin/bash --login
thalhallayakkety:
	ansible-playbook -i hosts  thalhallayakkety.yml

thoth: SHELL:=/bin/bash --login
thoth:
	ansible-playbook -i hosts  thoth.yml

azagthoth: SHELL:=/bin/bash --login
azagthoth:
	ansible-playbook -i hosts  azagthoth.yml

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
	@sleep 1
	@echo "$(USERNAME)"
	@echo "$(TARGET)"
	su -c "bash  debinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(USERNAME)"
	@echo "Now log out and log back in to attain sudo status"

initarch: USERNAME initsudoarch

initsudoarch:
	$(eval USERNAME := $(shell cat USERNAME))
	$(eval TARGET := $(shell pwd))
	@echo "This script requires root access to grant you sudo!"
	@sleep 1
	@echo "$(USERNAME)"
	@echo "$(TARGET)"
	su -c "bash  $(TARGET)/archinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(USERNAME)"
	@echo "Now log out and log back in to attain sudo status"

smxi:
	sudo bash installsmxi.sh

netselect:
	sudo bash netselect.sh

begin: USERNAME update

beginarch: USERNAME updatearch yaourt

yaourt:
	sudo cp pacman.conf /etc/
	sudo cp yaourtrc /etc/
	sudo pacman -Sy --noconfirm yaourt
	yaourt -S aurvote

rclone:
	$(eval TMP := $(shell mktemp -d --suffix=ThalhallaDOCKERTMP))
	chmod 777 $(TMP)
	cd $(TMP) ;\
	curl -O http://downloads.rclone.org/rclone-current-linux-amd64.zip ;\
	unzip rclone-current-linux-amd64.zip ;\
	sudo cp rclone-*/rclone /usr/local/bin/ ;\
	sudo chown root:root /usr/local/bin/rclone ;\
	sudo chmod 755 /usr/local/bin/rclone ;\
	sudo mkdir -p /usr/local/share/man/man1 ;\
	sudo cp rclone-*/rclone.1 /usr/local/share/man/man1/
	sudo mandb
	@echo "rclone config <--- to configure RCLONE"

tmuxinator:
	gem install tmuxinator
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
