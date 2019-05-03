# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_eshelf_session', domain: {
    production: ENV['LOGIN_COOKIE_DOMAIN'],
    staging: ENV['LOGIN_COOKIE_DOMAIN'],
    qa: ENV['LOGIN_COOKIE_DOMAIN']
  }.fetch(Rails.env.to_sym, :all)