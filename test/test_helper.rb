# Wear merged coveralls for rails
require 'coveralls'
Coveralls.wear_merged!('rails')

ENV["RAILS_ENV"] = 'test'
ENV['PERSISTENT_LINKER_URL'] = "http://localhost.persistent_linker/"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_bot'

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::JUnitReporter.new('test-results')]

# Make sure all Factories are loaded and actually work
FactoryBot.reload

# VCR is used to 'record' HTTP interactions with
# third party services used in tests, and play em
# back. Useful for efficiency, also useful for
# testing code against API's that not everyone
# has access to -- the responses can be cached
# and re-used.
require 'vcr'
require 'webmock'

# To allow us to do real HTTP requests in a VCR.turned_off, we
# have to tell webmock to let us.
WebMock.allow_net_connect!

VCR.configure do |c|
  c.default_cassette_options = { allow_playback_repeats: true, match_requests_on: [:method, :uri, :body], record: :once }
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock
  # c.debug_logger = $stderr
  c.filter_sensitive_data("http://primo.library.edu") { ENV['PRIMO_BASE_URL'] }
end

class MockRecordDecoratorViewContext
  def getit_record_url(record)
    "getit/#{record.id}"
  end

  def content_tag(tag_name, content)
    "<#{tag_name}>#{content}</#{tag_name}>"
  end
end

class ActiveSupport::TestCase
  def record_getit_path(record)
    "/records/#{record.id}/getit"
  end

  def record_getit_url(record)
    "http://test.host#{record_getit_path(record)}"
  end
end

class ActionController::TestRequest
  def performed?; end
end
