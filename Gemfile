source "https://rubygems.org"

gem 'rails', '~> 4.2.7'

# Middleware for jruby
gem 'jruby-rack', '~> 1.1.13'

# Add CORS support
gem 'rack-cors', '~> 0.2.0', require: 'rack/cors'

# Use MySQL
gem 'activerecord-jdbcmysql-adapter', '~> 1.3.0'

# Use Java openssl library
gem 'jruby-openssl', '~> 0.9.7-java'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.0.beta1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 2.7.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 3.1.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyrhino', '~> 2.0.0'

# Use the Compass CSS framework for sprites, etc.
gem 'compass-rails', '~> 2.0.0'

# Use modernizr to detect CORS availability
gem 'modernizr-rails', '~> 2.7.0'

# Use mustache for templating
# Fix to 0.99.4 cuz 0.99.5 broke my shit.
gem 'mustache', '0.99.4'
gem 'mustache-rails', github: 'NYULibraries/mustache-rails', tag: 'v0.2.3', require: 'mustache/railtie'

# Use the NYU Libraries assets gem for shared NYU Libraries assets
gem 'nyulibraries-assets', github: 'NYULibraries/nyulibraries-assets', tag: 'v4.6.8'
gem 'nyulibraries_errors', github: 'NYULibraries/nyulibraries_errors', tag: 'v1.0.0'

# Deploy the application with Formaggio deploy recipes
gem 'formaggio', github: 'NYULibraries/formaggio', branch: 'fix/puma-verifymode'

# Figs for configuration
gem 'figs', '~> 2.0.2'

# Font awesome for icons
gem 'font-awesome-rails', '~> 4.2.0'

# Development and testing gems
group :development, :test do
  gem 'teaspoon-jasmine', '~> 2.3.4'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'rspec-rails', '~> 3.1.0'
end

# Testing gems
group :test do
  gem 'coveralls', '~> 0.7.11', require: false
  gem 'vcr', '~> 2.9.0'
  gem 'webmock', '~> 1.20.0'
  gem 'cucumber-rails', '~> 1.4.2', require: false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'rspec-mocks'
end

# NYU customization gems
# Need to include exlibris-primo before citero
# so we use the nokogiri Xerces-J jar.
gem 'exlibris-nyu', github: 'NYULibraries/exlibris-nyu', tag: 'v2.2.0'
gem 'acts_as_citable', github: "NYULibraries/acts_as_citable", tag: 'v4.0.0'
gem 'ex_cite', '~> 2.1.0', require: 'ex_cite/engine'

gem 'omniauth-nyulibraries', github: 'NYULibraries/omniauth-nyulibraries', tag: 'v2.1.0'
gem 'devise', '~> 3.5.10'

# Use puma as the app server
gem 'puma', '~> 3.6.0'

# Dalli for caching with memcached
gem 'dalli', '~> 2.7.0'

# Use Kaminari for paging
gem 'kaminari', '~> 0.16.0'

# Use sorted for sorting
gem 'sorted', '~> 1.0.0'

# New Relic performance monitoring
gem 'newrelic_rpm', '~> 3.9.0'

# Acts as taggable on
gem 'acts-as-taggable-on', '~> 3.4.0'

# Convert old records with activerecord-import
gem 'activerecord-import', '~> 0.6.0'

gem 'pry', '~> 0.10.0'
gem 'pry-remote', '~> 0.1.8'

gem 'railties', '~> 4.2.7.1'

gem 'citero-renderers', github: "NYULibraries/citero-renderers", tag: "v1.0.0"
