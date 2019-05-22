# Default require
require 'formaggio/capistrano'

# Required variables
set :app_title, "eshelf"

# Overriding defaults
set :rvm_ruby_string, "ruby-2.6.2"
set :stages, ["staging", "qa", "production"]
set :new_relic_environments, ["none"]
