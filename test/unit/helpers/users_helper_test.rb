require 'test_helper'
class UsersHelperTest < ActionView::TestCase
  test "should return a link to records tagged with 'test tag'" do
    test_tag = ActsAsTaggableOn::Tag.find_or_create_with_like_by_name('test tag')
    assert_dom_equal '<a href="http://test.host/records?tag=test+tag">test tag</a>', link_to_tagged_records(test_tag)
  end
end
