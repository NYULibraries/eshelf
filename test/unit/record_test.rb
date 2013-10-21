require 'test_helper'

class RecordTest < ActiveSupport::TestCase
  setup do
    @user_record = records(:user_record)
    @tmp_user_record = records(:tmp_user_record)
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
    assert_equal("external2", @tmp_user_record.external_id)
    assert_equal("external_system2", @tmp_user_record.external_system)
    assert_equal("format2", @tmp_user_record.format)
    assert_equal("title 2", @tmp_user_record.title)
    assert_equal("author 2", @tmp_user_record.author)
    assert_equal("http://example.com/2", @tmp_user_record.url)
    assert_equal("title sort 2", @tmp_user_record.title_sort)
  end

  test "mass assignment error" do
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) {
      @user_record.update_attributes!(user_id: 1)
    }
    assert_raise(ActiveModel::MassAssignmentSecurity::Error) {
      @user_record.update_attributes!(tmp_user_id: 1)
    }
  end

  test "becomes external system returns self" do
    external_system = @user_record.becomes_external_system
    assert(@user_record == external_system)
  end
end
