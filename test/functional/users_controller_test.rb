# encoding: UTF-8
require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  include Devise::TestHelpers

  setup do
    @user = FactoryGirl.create(:user)
    @user_record = FactoryGirl.build(:user_primo_record1, user: @user)
    VCR.use_cassette('record becomes primo') do
      (@user_record = @user_record.becomes_external_system).save!
    end
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  test "should get account" do
    sign_in @user
    get :account
    assert_response :redirect
    # assert_response :success
    # assert_select "iframe", 1
  end

  test "should get tags" do
    sign_in @user
    @user.tag(@user_record, with: "tag one", on: :tags)
    get :tags
    assert_response :success
    # Should not have pagination
    assert_select "nav ul.pagination", 0
    # Should have a single tag in the list.
    assert_select "ul.tags-list" do |elements|
      elements.each do |element|
        assert_select element, "li a", { count: 1, text: "tag one", href: "records?tags=tag+one" }
      end
    end
  end

  test "should get 20 of 21 tags" do
    sign_in @user
    tags = %w{ tag1 tag2 tag3 tag4 tag5 tag6 tag7 tag8 tag9 tag10 tag11 tag12
      tag13 tag14 tag15 tag16 tag17 tag18 tag19 tag20 tag21 }.join(",")
    @user.tag(@user_record, with: tags, on: :tags)
    assert_equal(21, @user.owned_tags.count, "User should have 21 owned tags")
    get :tags
    assert_response :success
    # Should have pagination
    assert_select("nav ul.pagination") do |elements|
      assert_equal(1, elements.size, "Should have only 1 pagination element")
      elements.each do |element|
        assert_select element, "li.page.current > span", { count: 1, text: "1" }
        assert_select element, "li.page > a", { count: 1, text: "2", href: "users/tags?page=2" }
        assert_select element, "li.next > a", { count: 1, text: "Next &rsaquo;", href: "users/tags?page=2" }
        assert_select element, "li.last > a", { count: 1, text: "Last &raquo;", href: "users/tags?page=2" }
      end
    end
    # Should have 20 tags in the list.
    assert_select "ul.tags-list" do |elements|
      elements.each do |element|
        assert_select element, "li a", { count: 20 }
      end
    end
  end

  test "should only get the last 1 of 21 tags" do
    sign_in @user
    tags = %w{ tag1 tag2 tag3 tag4 tag5 tag6 tag7 tag8 tag9 tag10 tag11 tag12
      tag13 tag14 tag15 tag16 tag17 tag18 tag19 tag20 tag21 }.join(",")
    @user.tag(@user_record, with: tags, on: :tags)
    assert_equal(21, @user.owned_tags.count, "User should have 21 owned tags")
    get :tags, page: 2
    assert_response :success
    # Should have pagination
    assert_select("nav ul.pagination") do |elements|
      assert_equal(1, elements.size, "Should have only 1 pagination element")
      elements.each do |element|
        assert_select element, "li.first > a", { count: 1, text: "&laquo; First", href: "users/tags?page=1" }
        assert_select element, "li.prev > a", { count: 1, text: "&lsaquo; Prev", href: "users/tags?page=1" }
        assert_select element, "li.page > a", { count: 1, text: "1", href: "users/tags?page=1" }
        assert_select element, "li.page.current > span", { count: 1, text: "2" }
      end
    end
    # Should have 20 tags in the list.
    assert_select "ul.tags-list" do |elements|
      elements.each do |element|
        assert_select element, "li a", { count: 1 }
      end
    end
  end
end
