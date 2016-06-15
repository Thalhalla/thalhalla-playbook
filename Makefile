SHELL := /bin/bash
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

debian: hosts localbootstrap begin thalhalladeb nodejs thoth dev ruby bundle videodeb audiodeb  smxi

arch: localbootstraparch beginarch thalhallaarch azagthoth dev rubyarch bundle videoarch audioarch

dev: spf13 zsh

test: builddocker rundocker

bundle:
	-@rm Gemfile.lock
	bundle install

builddocker:
	/usr/bin/time -v docker build -t thalhalla-test .

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
	source ~/git/ansible/hacking/env-setup
	ansible-playbook -i hosts  update.yml

updatearch:
	sudo pacman -Syu --noconfirm

nodejs:
	source ~/git/ansible/hacking/env-setup
	ansible-playbook -i hosts  nodejs.yml

ruby:
	source ~/git/ansible/hacking/env-setup
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

USERNAME:
	@while [ -z "$$USERNAME23" ]; do \
		read -r -p "Enter the username you wish to associate with this run [USERNAME]: " USERNAME23; echo "$$USERNAME23">>USERNAME; cat USERNAME; \
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

hosts:
	cp hosts.example hosts
