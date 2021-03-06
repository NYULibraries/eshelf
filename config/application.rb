require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eshelf
  EXAMPLE_ORIGIN = 'example.com'

  class Application < Rails::Application
    config.eager_load_paths << Rails.root.join('lib')
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0
    config.eshelf_origins = config_for(:eshelf_origins)["origins"]

    # Cross Origin Request support
    # Set to a dummy value for tests
    whitelisted_origins = Rails.env.test? ? 
      Eshelf::EXAMPLE_ORIGIN : (config.eshelf_origins || [])

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins *whitelisted_origins
        resource %r{/records/from/\w+.json(\?.*)?}, headers: :any, methods: [:get], expose: 'X-CSRF-Token', credentials: true
        resource '/records.json', headers: :any, methods: [:post, :delete], expose: 'X-CSRF-Token', credentials: true
      end
    end

    # config.middleware.insert_after Rails::Rack::Logger, Rack::Cors, :logger => Rails.logger
    config.assets.prefix = "/eshelf/assets"

    # Enable serving of images, stylesheets, and JavaScripts from an asset server.
    if ENV['CDN_URL']
      config.action_controller.asset_host = ENV['CDN_URL']
    end

    # Default Mailer Host
    config.action_mailer.default_url_options = { host: (ENV['ESHELF_DOMAIN'] || 'https://eshelf.library.nyu.edu') }

    config.action_mailer.smtp_settings = {
      address:              ENV['SMTP_HOSTNAME'],
      port:                 ENV['SMTP_PORT'],
      domain:               ENV['SMTP_DOMAIN'],
      user_name:            ENV['SMTP_USERNAME'],
      password:             ENV['SMTP_PASSWORD'],
      authentication:       ENV['SMTP_AUTH_TYPE'],
      enable_starttls_auto: true
    }
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

if ENV['CDN_URL']
  ActionController::Base.asset_host = ENV['CDN_URL'] 
end

Raven.configure do |config|
  config.dsn = ENV['SENTRY_DSN']
  config.environments = ['staging','qa','production']
end