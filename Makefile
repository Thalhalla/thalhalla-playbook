all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""   1. make local       - run thalhalla playbook locally
	@echo ""   2. make full       - run thalhalla playbook on hosts file

begin: USERNAME update

play: begin dev thalhalla thoth video audio

local: localbootstrap play

full: bootstrap play

dev: zsh spf13 nodejs ruby

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
	ansible-playbook -i hosts  update.yml

nodejs:
	ansible-playbook -i hosts  nodejs.yml

ruby:
	ansible-playbook -i hosts  ruby.yml

zsh:
	ansible-playbook -i hosts  zsh.yml

video:
	ansible-playbook -i hosts  video.yml

audio:
	ansible-playbook -i hosts  audio.yml

spf13:
	ansible-playbook -i hosts  spf13.yml

thalhalla:
	ansible-playbook -i hosts  `cat NAME`.yml

thoth:
	ansible-playbook -i hosts  thoth.yml

prep: build localbootstrap

build:
	sudo apt-get install -y ansible git build-essential aptitude
	date -I>build

bootstrap:
	ansible-playbook -i hosts  bootstrapAnsible.yml

localbootstrap:
	sudo bash bootstrapansible.sh
	bash installansible.sh
	date -I>localbootstrap

NAME:
	@while [ -z "$$NAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [NAME]: " NAME; echo "$$NAME">>NAME; cat NAME; \
	done ;

USERNAME:
	@while [ -z "$$USERNAME" ]; do \
		read -r -p "Enter the name you wish to associate with this container [USERNAME]: " USERNAME; echo "$$USERNAME">>USERNAME; cat USERNAME; \
	done ;

clean:
	-rm localbootstrap
