# Wear coveralls
require 'coveralls'
Coveralls.wear!

ENV["RAILS_ENV"] = 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'authlogic'
require 'authlogic/test_case'
require 'factory_girl'


# Make sure all Factories are loaded and actually work
FactoryGirl.reload

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

@@primo_url = "bobcatdev.library.nyu.edu"

VCR.configure do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  # webmock needed for HTTPClient testing
  c.hook_into :webmock
  # c.debug_logger = $stderr
  c.filter_sensitive_data("primo.library.edu") { @@primo_url }
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
