require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic

  setup do
    @user = users(:user)
    @user_record = records(:user_primo_record1)
    VCR.use_cassette('record becomes primo', :record => :new_episodes) do
      @user_record.becomes_external_system.save
    end
  end

  test "should get account" do
    UserSession.create(@user)
    get :account
    assert_response :success
    assert_select "iframe", 1
  end

  test "should get tags" do
    UserSession.create(@user)
    @user.tag(@user_record, with: "tag one", on: :tags)
    get :tags
    assert_response :success
    assert_select "ul.tags-list" do |elements|
      elements.each do |element|
        assert_select element, "li a", { count: 1, text: "tag one", href: "records?tags=tag+one" }
      end
    end
  end
end
