# Wear merged coveralls for rails
require 'coveralls'
Coveralls.wear_merged!('rails')

ENV["RAILS_ENV"] ||= 'test'
ENV['PERSISTENT_LINKER_URL'] = "http://localhost.persistent_linker/"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'factory_bot'

require "minitest/reporters"
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new, Minitest::Reporters::JUnitReporter.new('test-results')]

Dir[File.expand_path("../support/**/*.rb", __FILE__)].each { |rb| require(rb) }

# Make sure all Factories are loaded and actually work
FactoryBot.reload

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
