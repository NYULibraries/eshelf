source "https://rubygems.org"

gem 'rails', '~> 5.2.3'
gem 'rake', '~> 10.1'

# Add CORS support
gem 'rack-cors', '~> 0.4.1', require: 'rack/cors'

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

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
group :no_docker do
  gem 'therubyracer', '~> 0.12.3'
end

gem 'listen', '~> 3.1.5'
gem 'bootsnap', '~> 1.4.2', require: false

# Use the Compass CSS framework for sprites, etc.
gem 'compass-rails', '~> 3.1.0'

# Use modernizr to detect CORS availability
gem 'modernizr-rails', '~> 2.7.0'

gem 'bootstrap-sass', '3.3.7'

# Use the NYU Libraries assets gem for shared NYU Libraries assets
gem 'nyulibraries_stylesheets', github: 'NYULibraries/nyulibraries_stylesheets', tag: 'v1.1.2'
gem 'nyulibraries_templates', github: 'NYULibraries/nyulibraries_templates', tag: 'v1.2.5'
gem 'nyulibraries_institutions', github: 'NYULibraries/nyulibraries_institutions', tag: 'v1.0.4'
gem 'nyulibraries_javascripts', github: 'NYULibraries/nyulibraries_javascripts', tag: 'v1.0.0'
gem 'nyulibraries_errors', github: 'NYULibraries/nyulibraries_errors', tag: 'v1.1.1'

# Deploy the application with Formaggio deploy recipes
gem 'formaggio', github: 'NYULibraries/formaggio', tag: 'v1.8.0'

# Figs for configuration
gem 'figs', '~> 2.0.2'

# Font awesome for icons
gem 'font-awesome-rails', '~> 4.7.0.5'

# Development and testing gems
group :development, :test do
  gem 'teaspoon-jasmine', '~> 2.3.4'
  gem 'factory_bot_rails', '~> 4.8.2'
  gem 'rspec-rails', '~> 3.7.0'
  gem 'rspec-its', '~> 1.2'
  gem 'pry', '~> 0.10.0'
  gem 'pry-remote', '~> 0.1.8'
  gem 'coveralls', '~> 0.8.20', require: false
  gem 'vcr', '~> 3.0.3'
  gem 'webmock', '~> 3.1.1'
  gem 'cucumber-rails', '~> 1.7.0', require: false
  gem 'database_cleaner', '~> 1.6.0'
  gem 'rspec-mocks'
  gem 'rspec_junit_formatter'
  gem 'minitest-reporters'
  gem 'rails-controller-testing'
end

# NYU customization gems
gem 'exlibris-nyu', github: 'NYULibraries/exlibris-nyu', tag: 'v2.4.1'
gem 'exlibris-primo', github: 'NYULibraries/exlibris-primo', tag: 'v2.2.0'

gem 'citero', github: 'NYULibraries/citero', tag: 'v1.0.2'
gem 'acts_as_citable', github: 'NYULibraries/acts_as_citable', branch: 'feature/rails5' #tag: 'v5.0.0.beta'

gem 'omniauth-nyulibraries', github: 'NYULibraries/omniauth-nyulibraries', tag: 'v2.1.2'
gem 'devise', '~> 4.6.0'
gem 'rest-client', '~> 2.0.2'

# Dalli for caching with memcached
gem 'dalli', '~> 2.7.0'

# Use Kaminari for paging
gem 'kaminari', '~> 1.1.1'

# Acts as taggable on
gem 'acts-as-taggable-on', '~> 6.0.0'

# Convert old records with activerecord-import
# gem 'activerecord-import', '~> 0.18.0'

gem 'sentry-raven', '~> 2'
