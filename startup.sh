#!/bin/bash
# Print out process ID
echo $$
# Load up RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Switch directory to where this script resides
cd $(dirname ${BASH_SOURCE[0]})
# Find out current ruby version
RUBY_VERSION=$(head -n 1 .ruby-version)
# Set default version
DEFAULT_RUBY_VERSION="jruby-1.7.22"
# RVM set to ruby version
rvm use ${RUBY_VERSION-$DEFAULT_RUBY_VERSION}
# Start puma under RAILS_ENV passed through argument
RAILS_ENV=$1 bundle exec rake formaggio:puma:restart[9000,'ssl']
