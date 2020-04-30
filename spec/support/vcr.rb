require 'vcr'
require 'webmock/rspec'
WebMock.disable_net_connect!(allow_localhost: true)

VCR.configure do |c|
  #the directory where your cassettes will be saved
  c.cassette_library_dir = 'spec/vcr'
  # your HTTP request service.
  c.hook_into :webmock
  c.default_cassette_options = { allow_playback_repeats: true, match_requests_on: [:method, :uri, :body], record: :new_episodes }
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end