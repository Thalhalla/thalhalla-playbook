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

initdebian: MYID initsudo

debian: localbootstrap begin thalhalladeb nodejs thoth dev ruby bundle videodeb audiodeb  smxi

arch: MYID localbootstraparch beginarch thalhallaarch azagthoth dev rubyarch bundle videoarch audioarch nvm

dev: janus zsh

test: builddocker rundocker

bundle:
	-@rm Gemfile.lock
	bundle install

builddocker:
	/usr/bin/time -v docker build -t thalhalla-test .

nvm:
	bash  ./nvm.sh
	echo "nvm install lts/boron"
	echo "nvm alias default lts/boron"

rundocker:
	$(eval TMP := $(shell mktemp -d --suffix=ThalhallaDOCKERTMP))
	chmod 777 $(TMP)
	@docker run --name=thalhalla-test \
	--cidfile="cid" \
	-v $(TMP):/tmp \
	-d \
	--privileged \
	-t thalhalla-test

update:
	ansible-playbook -i hosts  update.yml

updatearch:
	sudo pacman -Syu --noconfirm

nodejs:
	ansible-playbook -i hosts  nodejs.yml

ruby:
	ansible-playbook -i hosts  ruby.yml

rubyarch:
	bash installrvm.sh
	bash gemInstaller.sh

zsh:
	ansible-playbook -i hosts  zsh.yml

videodeb:
	ansible-playbook -i hosts  videodeb.yml

audiodeb:
	ansible-playbook -i hosts  audiodeb.yml

videoarch:
	ansible-playbook -i hosts  videoarch.yml

audioarch:
	ansible-playbook -i hosts  audioarch.yml

spf13:
	ansible-playbook -i hosts  spf13.yml

janus:
	curl -L https://bit.ly/janus-bootstrap | bash

thalhallaarch:
	ansible-playbook -i hosts  thalhallaarch.yml

thalhalladeb:
	ansible-playbook -i hosts  thalhalladeb.yml

thoth:
	ansible-playbook -i hosts  thoth.yml

azagthoth:
	ansible-playbook -i hosts  azagthoth.yml

prep: build localbootstrap

build:
	sudo apt-get install -y ansible git build-essential aptitude
	date -I>build

bootstrap:
	ansible-playbook -i hosts  bootstrapAnsible.yml

localbootstraparch:
	sudo pacman -S --noconfirm ansible
	date -I>localbootstraparch

localbootstrap:
	sudo bash bootstrapansible.sh
	bash installansible.sh
	date -I>localbootstrap

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

MYID:
	@while [ -z "$$MYID" ]; do \
		read -r -p "Enter the MYID directory you wish to associate with this new backup [MYID]: " MYID; echo "$$MYID">MYID; cat MYID; \
	done ;

clean:
	-rm localbootstrap

initsudo:
	$(eval MYID := $(shell cat MYID))
	$(eval TARGET := $(shell pwd))
	@echo "This script requires root access to grant you sudo!"
	@sleep 1
	@echo "$(MYID)"
	@echo "$(TARGET)"
	su -c "bash  debinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(MYID)"
	@echo "Now log out and log back in to attain sudo status"

initarch: MYID initsudoarch

initsudoarch:
	$(eval MYID := $(shell cat MYID))
	$(eval TARGET := $(shell pwd))
	@echo "This script requires root access to grant you sudo!"
	@sleep 1
	@echo "$(MYID)"
	@echo "$(TARGET)"
	su -c "bash  $(TARGET)/archinstall_sudo.sh; bash $(TARGET)/acquire_sudo.sh $(MYID)"
	@echo "Now log out and log back in to attain sudo status"

smxi:
	sudo bash installsmxi.sh

netselect:
	sudo bash netselect.sh

begin: MYID update

beginarch: MYID updatearch yaourt

yaourt:
	sudo cp pacman.conf /etc/
	sudo cp yaourtrc /etc/
	sudo pacman -Sy --noconfirm yaourt
	yaourt -S aurvote
