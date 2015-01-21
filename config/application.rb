require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'figs'
# Don't run this initializer on travis.
Figs.load(stage: Rails.env) unless ENV['TRAVIS']

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Eshelf
  EXAMPLE_ORIGIN = 'example.com'

  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Cross Origin Request support
    # Set to a dummy value for tests
    whitelisted_origins = Rails.env.test? ?
      Eshelf::EXAMPLE_ORIGIN : (Figs.env['ESHELF_ORIGINS'] || [])

    config.middleware.use Rack::Cors do
      allow do
        origins *whitelisted_origins
        resource %r{/records/from/\w+.json(\?.*)?}, headers: :any, methods: [:get], expose: 'X-CSRF-Token'
        resource '/records.json', headers: :any, methods: [:post, :delete], expose: 'X-CSRF-Token'
      end
    end

    # Default Mailer Host
    config.action_mailer.default_url_options = {host: 'https://eshelf.library.nyu.edu'}
  end
end
