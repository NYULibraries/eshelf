source "https://rubygems.org"
gem 'rake', '~> 10.1.0'
# Add CORS support
gem 'rack-cors', :require => 'rack/cors'
gem "rails", "~> 3.2.16"
gem "json", "~> 1.8.0"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails",   "~> 3.2.6"
  gem "coffee-rails", "~> 3.2.2"
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem "therubyrhino", "~> 2.0.2", platform: :jruby
  gem "therubyracer", "~> 0.12.0", platform: :ruby
  gem "uglifier", "~> 2.2.1"
  gem "compass-rails", "~> 1.0.3"
  gem "nyulibraries-assets", git: "git://github.com/NYULibraries/nyulibraries-assets.git", tag: 'v2.0.1'
end

# Development gems
group :development do
  gem "better_errors", "~> 1.0.1", platform: :ruby
  gem "binding_of_caller", "~> 0.7.1", platform: :ruby
  gem "ruby-debug", "~> 0.10.4", platform: :jruby
  gem "debugger", "~> 1.6.0", platform: :mri
  gem "pry"
end

# Development and testing gems
group :development, :test do
  gem "jasmine", "~> 1.3.2"
  gem "teaspoon", "~> 0.7.7"
end

# Testing gems
group :test do
  gem 'coveralls', "~> 0.7.0", require: false
  gem "vcr", "~> 2.6.0"
  gem "webmock", "~> 1.15.0"
end

# NYU customization gems
# Need to include exlibris-primo before citero
# so we use the nokogiri Xerces-J jar.
gem "nokogiri", "~>1.6.0"
gem "exlibris-nyu", git: "git://github.com/NYULibraries/exlibris-nyu.git", branch: "development"
gem "authpds-nyu", git: "git://github.com/NYULibraries/authpds-nyu.git", tag: 'v1.1.3'
gem "acts_as_citable", "~> 2.0.0"
gem "ex_cite", "~> 1.3.0"
gem 'nyulibraries_deploy', git: "git://github.com/NYULibraries/nyulibraries_deploy.git", tag: "v3.2.1"

# Middleware for jruby
gem "jruby-rack", "~> 1.1.13", platform: :jruby

# Use MySQL
gem "activerecord-jdbcmysql-adapter", "~> 1.3.0", platform: :jruby
gem "mysql2", "~> 0.3.11", platform: :ruby

# Use jquery
gem "jquery-rails", "~> 3.0.0"

# Use modernizr
gem "modernizr-rails", "~> 2.7.0"

# Use mustache
# Fix to 0.99.4 cuz 0.99.5 broke my shit.
gem "mustache", "0.99.4"
gem "mustache-rails", "~> 0.2.3", :require => "mustache/railtie"

# For config settings
gem "rails_config", "~> 0.3.2"

# Use puma as the app server
gem "puma", "~> 2.7.0"

# Dalli for caching with memcached
gem "dalli", "~> 2.6.0"

# Use Kaminari for paging
gem "kaminari", "~> 0.15.0"

# Use sorted for sorting
gem "sorted", "~> 1.0.0"

# New Relic performance monitoring
gem "newrelic_rpm", "~> 3.7.0"

# Acts as taggable on
gem 'acts-as-taggable-on', '~> 2.4.0'

# Convert old records with activerecord-import
gem "activerecord-import", "~> 0.4.1"
