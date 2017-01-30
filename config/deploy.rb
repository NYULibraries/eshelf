# Default require
require 'formaggio/capistrano'
# Specifying server to puma
require 'formaggio/capistrano/server/puma'

# Required variables
set :app_title, "eshelf"

# Overriding defaults
set :rvm_ruby_string, "jruby-9.1.7.0"
set :stages, ["staging", "qa", "production"]
set :recipient, "lib-eshelf-admin@nyu.edu"
