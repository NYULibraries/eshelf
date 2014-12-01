# Be sure to restart your server when you modify this file.
Rails.application.config.session_store ActionDispatch::Session::CacheStore,
  key: '_eshelf_session', compress: true

# Rails.application.config.session_store ActionDispatch::Session::CacheStore, key: '_eshelf_session',
#     memcache_server: '127.0.0.1:11211', namespace: 'Eshelf', expires_in: 2.hours, compress: true
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Eshelf::Application.config.session_store :active_record_store
