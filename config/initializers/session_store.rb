# Be sure to restart your server when you modify this file.

Rails.application.config.session_store ActionDispatch::Session::CacheStore, key: '_eshelf_session', :expire_after => 1.day, domain: ENV['LOGIN_COOKIE_DOMAIN']
