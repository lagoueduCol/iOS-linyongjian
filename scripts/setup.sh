#!/bin/sh


# Install ruby using rbenv
ruby_version=`cat .ruby-version`
if [[ ! -d "$HOME/.rbenv/versions/$ruby_version" ]]; then
  rbenv install $ruby_version;
  rbenv init
fi

# Install bunlder
gem install bundler

# Install all gems
bundle install

# Install all pods
bundle exec pod install

# Create alias
. ~/.zshrc && [ `alias | grep "pod" | wc -l` = 0 ] && echo 'alias pod="bundle exec pod"' >> $HOME/.zshrc && . ~/.zshrc
