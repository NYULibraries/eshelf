require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  setup do
    @user_record = FactoryBot.build(:user_record)
    @tmp_user_record = FactoryBot.build(:tmp_user_record)
  end

  test "user record" do
    assert_equal("external1", @user_record.external_id)
    assert_equal("external_system1", @user_record.external_system)
    assert_equal("format1", @user_record.format)
    assert_equal("title 1", @user_record.title)
    assert_equal("author 1", @user_record.author)
    assert_equal("http://example.com/1", @user_record.url)
    assert_equal("title sort 1", @user_record.title_sort)
    assert_equal("book", @user_record.content_type)
  end

  test "tmp user record" do
    assert_equal("external1", @tmp_user_record.external_id)
    assert_equal("external_system1", @tmp_user_record.external_system)
    assert_equal("format1", @tmp_user_record.format)
    assert_equal("title 1", @tmp_user_record.title)
    assert_equal("author 1", @tmp_user_record.author)
    assert_equal("http://example.com/1", @tmp_user_record.url)
    assert_equal("title sort 1", @tmp_user_record.title_sort)
  end

  test "becomes external system returns self" do
    external_system = @user_record.becomes_external_system
    assert(@user_record == external_system)
  end
end
