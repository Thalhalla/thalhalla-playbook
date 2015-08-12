#!/bin/bash
curl -sSL https://rvm.io/mpapis.asc | gpg2 --import -
curl -L get.rvm.io | bash -s stable
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm requirements
# rvm list known
# rvm install 1.9.3                # Latest known patch level
#rvm list         # List rubies only
#rvm list gemsets # List rubies and gemsets
#rvm gemset list  # List gemsets for current ruby
#rvm system                 # For system ruby, with fallback to default 
#rvm use jruby              # For current session only
#rvm use --default 1.9.3    # For current and new sessions
#rvm use --ruby-version rbx # For current session and this project
#RVM will automatically use a ruby and gemset when you `cd` to a project directory.
#Read more on project files:
#- https://rvm.io/workflow/projects/#ruby-versions
#Using ruby and gems
#-------------------
#After selecting Ruby work as usual:
# ruby -v

echo 0


