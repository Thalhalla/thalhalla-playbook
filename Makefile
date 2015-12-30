all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make local       - run thalhalla playbook locally
	@echo ""   2. make full       - run thalhalla playbook on hosts file

begin: USERNAME update

play: begin dev thoth

local: localbootstrap play

full: bootstrap play

dev: zsh spf13 ruby nodejs

thoth: thalhalla

bundle:
	-@rm Gemfile.lock
	bundle install

update:
	ansible-playbook -i hosts  update.yml

nodejs:
	ansible-playbook -i hosts  nodejs.yml

ruby:
	ansible-playbook -i hosts  ruby.yml

zsh:
	ansible-playbook -i hosts  zsh.yml

spf13:
	ansible-playbook -i hosts  spf13.yml

thalhalla:
	ansible-playbook -i hosts  `cat NAME`.yml

prep: build localbootstrap

build:
	sudo apt-get install -y ansible git build-essential aptitude
	date -I>build

bootstrap:
	ansible-playbook -i hosts  bootstrapAnsible.yml

localbootstrap:
	sudo bash bootstrapansible.sh
	sudo bash installansible.sh
	date -I>localbootstrap

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

USERNAME:
	@while [ -z "$$USERNAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [USERNAME]: " USERNAME; echo "$$USERNAME">>USERNAME; cat USERNAME; \
	done ;
