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
# Stop puma under RAILS_ENV
RAILS_ENVIRONMENT=$(ps u -U $(whoami) | grep 'java' | head -1 | grep -Po '(?<=(-e )).*(?=( -t))')
DEFAULT_RAILS_ENVIRONMENT="development"
RAILS_ENV=${RAILS_ENVIRONMENT-$DEFAULT_RAILS_ENVIRONMENT} bundle exec rake formaggio:puma:stop[9000,'ssl']
