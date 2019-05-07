require_relative 'boot'

require 'rails/all'

require 'figs'
# Don't run this initializer on CIRCLECI.
Figs.load(stage: Rails.env) unless ENV['CIRCLECI']

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eshelf
  EXAMPLE_ORIGIN = 'example.com'

  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join('lib')
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    # Cross Origin Request support
    # Set to a dummy value for tests
    whitelisted_origins = Rails.env.test? ? 
      Eshelf::EXAMPLE_ORIGIN : (Figs.env['ESHELF_ORIGINS'] || [])

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        # origins 'http://localhost:8004', 'localhost', '127.0.0.1', 'localhost:8004'
        origins *whitelisted_origins
        resource %r{/records/from/\w+.json(\?.*)?}, headers: :any, methods: [:get], expose: 'X-CSRF-Token'
        resource '/records.json', headers: :any, methods: [:post, :delete], expose: 'X-CSRF-Token'
      end
    end

    # config.middleware.insert_after Rails::Rack::Logger, Rack::Cors, :logger => Rails.logger

    # Default Mailer Host
    config.action_mailer.default_url_options = {host: 'https://eshelf.library.nyu.edu'}
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environments = ['staging','qa','production']
end