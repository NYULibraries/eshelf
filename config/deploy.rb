# Default require
require 'formaggio/capistrano'
# Specifying server to puma
require 'formaggio/capistrano/server/puma'

# Required variables
set :app_title, "eshelf"

# Overriding defaults
set :rvm_ruby_string, "jruby-1.7.16"
set :stages, ["staging", "production"]
set :recipient, "eshelf.admin@library.nyu.edu"
