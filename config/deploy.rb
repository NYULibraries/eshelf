# Default require
require 'formaggio/capistrano'
# Specifying server to puma
require 'formaggio/capistrano/server/puma'

# Required variables
set :app_title, "eshelf"

# Overriding defaults
set :rvm_ruby_string, "ruby-2.3.3"
set :stages, ["staging", "qa", "production"]
set :recipient, "lib-eshelf-admin@nyu.edu"
set :puma_threads, '40:80'
