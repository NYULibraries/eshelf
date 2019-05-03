# Be sure to restart your server when you modify this file.

Rails.application.config.session_store ActionDispatch::Session::CacheStore, key: '_eshelf_session', domain: ENV['LOGIN_COOKIE_DOMAIN']
