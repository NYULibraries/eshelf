require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup do
    @user = FactoryGirl.create(:user)
    @tmp_user = FactoryGirl.create(:tmp_user)
    @user_record = FactoryGirl.build(:user_primo_record1, user: @user)
    @tmp_user_record = FactoryGirl.build(:tmp_user_primo_record1, tmp_user: @tmp_user)
    @primo_records = [@user_record, @tmp_user_record]
    @primo_records << FactoryGirl.build(:user_primo_record2, user: @user)
    @primo_records << FactoryGirl.build(:tmp_user_primo_record2, tmp_user: @tmp_user)
    VCR.use_cassette('record becomes primo', :record => :new_episodes) do
      @primo_records.each do |primo_record|
        primo_record.becomes_external_system.save!
      end
    end
    activate_authlogic
    session[:tmp_user] = nil
  end

  test "should destroy tmp user" do
    session[:tmp_user] = @tmp_user
    UserSession.create(@user)
    assert_difference('TmpUser.count', -1) do
      get :validate
    end
    assert_nil(session[:tmp_user])
  end

  # test "should convert tmp user records to user records" do
  #   session[:tmp_user] = @tmp_user
  #   UserSession.create(@user)
  #   assert_difference('@user.records.reload.count', 1) do
  #     get :validate
  #   end
  #   # Should delete the tmp session
  #   assert_nil(session[:tmp_user])
  # end

end
