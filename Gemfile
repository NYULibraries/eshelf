source "https://rubygems.org"

gem 'rails', '~> 5.2.4'
gem 'rake', '~> 13.0'

# Add CORS support
gem 'rack-cors', '~> 1.0.4', require: 'rack/cors'

# Use MySQL
#gem 'sqlite3'
gem 'mysql2', '~> 0.4.10'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.2.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2.1'

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.3.1'

gem 'listen', '~> 3.1.5'
gem 'bootsnap', '~> 1.4.2', require: false

# Use the Compass CSS framework for sprites, etc.
gem 'compass-rails', '~> 3.1.0'

# Use modernizr to detect CORS availability
gem 'modernizr-rails', '~> 2.7.0'

gem 'bootstrap-sass', '~> 3.4.1'

# Use the NYU Libraries assets gem for shared NYU Libraries assets
gem 'nyulibraries_stylesheets', github: 'NYULibraries/nyulibraries_stylesheets', tag: 'v1.1.2'
gem 'nyulibraries_templates', github: 'NYULibraries/nyulibraries_templates', tag: 'v1.4.0'
gem 'nyulibraries_institutions', github: 'NYULibraries/nyulibraries_institutions', tag: 'v1.0.4'
gem 'nyulibraries_javascripts', github: 'NYULibraries/nyulibraries_javascripts', tag: 'v1.0.0'
gem 'nyulibraries_errors', github: 'NYULibraries/nyulibraries_errors', tag: 'v1.1.1'

# Font awesome for icons
gem 'font-awesome-rails', '~> 4.7.0.5'

gem 'citero', github: 'NYULibraries/citero', tag: 'v1.0.3'
gem 'acts_as_citable', github: 'NYULibraries/acts_as_citable', tag: 'v5.1.0'

gem 'omniauth-nyulibraries', github: 'NYULibraries/omniauth-nyulibraries', tag: 'v2.2.1'
# lock omniauth: version 2 breaks authentication with "Not found. Authentication passthru." at /users/auth/nyulibraries
# no test failures to match the authentication failure on dev
# need to resolve this error AND add tests that fail on this update
gem 'omniauth', '< 2'
gem 'devise', '~> 4.8'
gem 'rest-client', '~> 2.1.0'
gem 'faraday', '~> 1'

# Dalli for caching with memcached
# gem 'dalli', '~> 2.7.0'

# Use Kaminari for paging
gem 'kaminari', '~> 1.2.1'

# Acts as taggable on
gem 'acts-as-taggable-on', '~> 6.0.0'

# Convert old records with activerecord-import
# gem 'activerecord-import', '~> 0.18.0'

gem 'sentry-raven', '~> 3'

# Development and testing gems
group :development, :test do
  gem 'teaspoon', github: 'jejacks0n/teaspoon', branch: 'master'
  gem 'teaspoon-jasmine', '~> 2.3.4'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'rspec-its', '~> 1.2'
  gem 'pry', '~> 0.10.0'
  gem 'pry-remote', '~> 0.1.8'
  gem 'coveralls', '~> 0.8.20', require: false
  gem 'vcr', '~> 3.0.3'
  gem 'webmock', '~> 3.5.0'
  gem 'database_cleaner', '~> 1.6.0'
  gem 'rspec-mocks'
  gem 'rspec_junit_formatter'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'

  gem 'selenium-webdriver', '~> 3.0'
  gem 'webdrivers', '~> 4.2.0'
end

group :production do
  gem 'unicorn', '~> 5.3.0'
end

gem 'prometheus-client', '~> 2.0.0'
