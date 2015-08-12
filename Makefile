all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make build       - run apt-get essentials 
	@echo ""   2. make bootstrap       - run bootstrap playbook 
	@echo ""   3. make play       - run thalhalla playbook 

play: USERNAME update thalhalla

full: play zsh spf13 ruby nodejs

update:
	ansible-playbook update.yml

nodejs:
	ansible-playbook nodejs.yml

ruby:
	ansible-playbook ruby.yml

zsh:
	ansible-playbook zsh.yml

spf13:
	ansible-playbook spf13.yml

thalhalla:
	ansible-playbook `cat NAME`.yml

prep: build bootstrap

build:
	sudo apt-get install -y ansible git build-essential aptitude

bootstrap:
	ansible-playbook bootstrapAnsible.yml

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

USERNAME:
	@while [ -z "$$USERNAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [USERNAME]: " USERNAME; echo "$$USERNAME">>USERNAME; cat USERNAME; \
	done ;
