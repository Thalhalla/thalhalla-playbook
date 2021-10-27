#!/bin/bash
TARGET_RUBY=2.7
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -L get.rvm.io | bash -s stable
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
rvm requirements
rvm get stable --auto-dotfiles
rvm install $TARGET_RUBY
rvm use --default $TARGET_RUBUY
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
LINE_TO_ADD='source ~/.profile'
ZSHRC_LOCATION=~/.zshrc
BASH_PROFILE_LOCATION=~/.bash_profile

check_if_line_exists_zshrc()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" $ZSHRC_LOCATION
}

add_line_to_zshrc()
{
  TARGET_FILE=$ZSHRC_LOCATION
    [ -w "$TARGET_FILE" ] || TARGET_FILE=$ZSHRC_LOCATION
    printf "%s\n" "$LINE_TO_ADD" >> "$TARGET_FILE"
}

check_if_line_exists_bash_profile()
{
    # grep wont care if one or both files dont exist.
    grep -qsFx "$LINE_TO_ADD" $BASH_PROFILE_LOCATION
}

add_line_to_bash_profile()
{
  TARGET_FILE=$BASH_PROFILE_LOCATION
    [ -w "$TARGET_FILE" ] || TARGET_FILE=$BASH_PROFILE_LOCATION
    printf "%s\n" "$LINE_TO_ADD" >> "$TARGET_FILE"
}

check_if_line_exists_zshrc || add_line_to_zshrc
check_if_line_exists_bash_profile || add_line_to_bash_profile

echo 0
