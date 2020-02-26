# encoding: UTF-8
require 'test_helper'

class BaseRecordDecoratorTest < ActiveSupport::TestCase
  setup do
    VCR.use_cassette('record becomes primo') do
      @record = FactoryBot.build(:user_primo_record1)
      # @record.becomes_external_system.save
    end
    @base_decorated_record = nil
    @base_decorated_record_with_view_context = nil
  end

  test "base new" do
    assert_nothing_raised { base_decorated_record }
    assert_nothing_raised { base_decorated_record_with_view_context }
  end

  test "base view context" do
    assert_nil base_decorated_record.view_context
    assert_not_nil base_decorated_record_with_view_context.view_context
  end

  def base_decorated_record
    @base_decorated_record ||= RecordDecorator::Base.new(@record)
  end

  def base_decorated_record_with_view_context
    @base_decorated_record_with_view_context ||= RecordDecorator::Base.new(@record, MockRecordDecoratorViewContext.new)
  end
end
