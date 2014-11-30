require 'test_helper'

class RecordsControllerTest < ActionController::TestCase

  setup do
    activate_authlogic
    @user = FactoryGirl.create(:user)
    @tmp_user = FactoryGirl.create(:tmp_user)
    @user_record = FactoryGirl.build(:user_primo_record1)
    @user_record2 = FactoryGirl.build(:user_primo_record2)
    @tmp_user_record = FactoryGirl.build(:tmp_user_primo_record1)
    @tmp_user_record2 = FactoryGirl.build(:tmp_user_primo_record2)
    @primo_records = [@user_primo_record1, @user_primo_record2,
      @tmp_user_primo_record, @tmp_user_primo_record2]
    VCR.use_cassette('record becomes primo', :record => :new_episodes) do
      @primo_records.each do |primo_record|
        primo_record.becomes_external_system.save
      end
    end
    session[:tmp_user] = nil
    request.env['HTTP_ORIGIN'] = nil
    # Pretend we've already checked PDS/Shibboleth for the session
    # and we have a session
    @controller.session[:attempted_sso] = true
    @controller.session[:session_id] = "FakeSessionID"
    # Setup a Fake Origin
    Figs.env['ESHELF_ORIGINS'] = [Eshelf::EXAMPLE_ORIGIN]
   end

  test "should have title of BobCat" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat"
  end

  test "should not have back to search results" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select ".back-to .icons-famfamfam-arrow_undo", 0
    assert_select ".back-to a", 0
  end

  test "should have back to search results" do
    bobcat_search_results = "http://bobcat.library.nyu.edu/primo_library/libweb/action/search.do?"+
      "dscnt=0&vl(378633853UI1)=all_items&tab=all&dstmp=1366313551347&srt=rank&ct=search&mode=Basic&dum=true&"+
        "vl(212921975UI0)=any&indx=1&vl(1UIStartWith0)=contains&vl(freeText0)=digital+divide&vid=NYU&fn=search"
    session[:referer] = bobcat_search_results
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select ".back-to .icons-famfamfam-arrow_undo", 1
    assert_select ".back-to a", {count: 1, text: "Back to search results", href: bobcat_search_results}
  end

  test "should show records controls" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select ".nyu-container .btn-toolbar", 1
  end

  test "should show records record path with delete method" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select ".nyu-container .btn-toolbar > .btn-group > a#delete.btn",
      {count: 1, data: {method: :delete, confirm: "Are you sure you want to delete these records?"}}
  end

  test "should show user tag search and tags link only when there are tags" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#user_tags_search.form-search.js", 0
    assert_select "div#user_tags", 0
    @user.tag(@user_record, with: "tag one", on: :tags)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#user_tags_search.form-search.js" do |elements|
      elements.each do |element|
        assert_select element, ".search-query", { placeholder: "Filter labels" }
      end
    end
    assert_select "div#user_tags" do |elements|
      elements.each do |element|
        assert_select element, "ul.nav-list > li > a", { count: 1, text: "Your labels", href: "users/tags"}
      end
    end
  end

  test "should get new tmp user records index" do
    assert_difference('TmpUser.count') do
      get :index
    end
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_empty assigns(:records)
    assert_select ".nyu-container .results .result", 0
  end

  test "should get existing tmp user records index" do
    session[:tmp_user] = @tmp_user
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
    assert_select ".nyu-container .results .result", 3
  end

  test "should get user records index" do
    UserSession.create(@user)
    get :index
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
    assert_select ".nyu-container .results .result", 4
  end

  test "should get new tmp user records index html" do
    assert_difference('TmpUser.count') do
      get :index, format: "html"
    end
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_empty assigns(:records)
    assert_select ".nyu-container .results .result", 0
  end

  test "should get existing tmp user records index html" do
    session[:tmp_user] = @tmp_user
    get :index, format: "html"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
    assert_select ".nyu-container .results .result", 3
  end

  test "should get user records index html" do
    UserSession.create(@user)
    get :index, format: "html"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
    assert_select ".nyu-container .results .result", 4
  end

  test "should get new tmp user records index json" do
    get :index, format: "json"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_empty assigns(:records)
  end

  test "should get existing tmp user records index json" do
    session[:tmp_user] = @tmp_user
    get :index, format: "json"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
  end

  test "should get user records index json" do
    UserSession.create(@user)
    get :index, format: "json"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
  end

  test "should get new tmp user records index xml" do
    assert_difference('TmpUser.count') do
      get :index, format: "xml"
    end
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_empty assigns(:records)
  end

  test "should get existing tmp user records index xml" do
    session[:tmp_user] = @tmp_user
    get :index, format: "xml"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
  end

  test "should get user records index xml" do
    UserSession.create(@user)
    get :index, format: "xml"
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_not_nil assigns(:records)
    assert_not_empty assigns(:records)
  end

  test "should create new tmp user record json" do
    assert_difference(['TmpUser.count', 'Record.count', 'Location.count']) do
      VCR.use_cassette('tmp user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should create existing tmp user record json" do
    session[:tmp_user] = @tmp_user
    assert_difference(['@tmp_user.records.count', 'Location.count']) do
      VCR.use_cassette('tmp user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should create user record json" do
    UserSession.create(@user)
    assert_difference(['@user.records.count', 'Location.count']) do
      VCR.use_cassette('user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should create new tmp user record CORS json" do
    request.env['HTTP_ORIGIN'] = "http://#{Eshelf::EXAMPLE_ORIGIN}"
    assert_difference(['TmpUser.count', 'Record.count', 'Location.count']) do
      VCR.use_cassette('tmp user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should create existing tmp user record CORS json" do
    request.env['HTTP_ORIGIN'] = "https://#{Eshelf::EXAMPLE_ORIGIN}"
    session[:tmp_user] = @tmp_user
    assert_difference(['@tmp_user.records.count', 'Location.count']) do
      VCR.use_cassette('tmp user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should create user record CORS json" do
    request.env['HTTP_ORIGIN'] = "http://#{Eshelf::EXAMPLE_ORIGIN}"
    UserSession.create(@user)
    assert_difference(['@user.records.count', 'Location.count']) do
      VCR.use_cassette('user record becomes primo') do
        post :create, format: "json", record: { external_id: "nyu_aleph001044111", external_system: "primo" }
      end
    end
    assert_response :created
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
    assert_equal 'Record was successfully created.', flash[:notice]
  end

  test "should show existing tmp user record" do
    session[:tmp_user] = @tmp_user
    get :show, format: "json", id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "xml", id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "ris", id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "bibtex", id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should show user record" do
    UserSession.create(@user)
    get :show, format: "json", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "xml", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "ris", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :show, format: "bibtex", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should update user record with tag" do
    UserSession.create(@user)
    assert_difference(['ActsAsTaggableOn::Tag.count', 'ActsAsTaggableOn::Tagging.count']) do
      put :update, format: "html", id: @user_record.id, record: { tag_list: "new tag" }
      assert_response :found
      assert_nil response.headers['X-CSRF-Token']
    end
    assert_difference(['ActsAsTaggableOn::Tag.count', 'ActsAsTaggableOn::Tagging.count']) do
      put :update, format: "json", id: @user_record.id, record: { tag_list: "new tag, another new tag" }
      assert_response :no_content
      assert_nil response.headers['X-CSRF-Token']
    end
    assert_difference(['ActsAsTaggableOn::Tag.count', 'ActsAsTaggableOn::Tagging.count']) do
      put :update, format: "xml", id: @user_record.id, record: { tag_list: "new tag, another new tag, yet another new tag" }
      assert_response :no_content
      assert_nil response.headers['X-CSRF-Token']
    end
  end

  # test "disallowed formats show existing tmp user record" do
  #   cookies[:tmp_user] = @tmp_user
  #   get :show, format: "html", id: @tmp_user_record.id
  #   assert_response :not_acceptable
  #   get :show, id: @tmp_user_record.id
  #   assert_response :not_acceptable
  # end
  #
  # test "disallowed formats show user record" do
  #   UserSession.create(@user)
  #   get :show, format: "html", id: @user_record.id
  #   assert_response :not_acceptable
  #   get :show, id: @user_record.id
  #   assert_response :not_acceptable
  # end

  test "should show by external system existing tmp user record" do
    session[:tmp_user] = @tmp_user
    get :from_external_system, format: "json", external_system: @tmp_user_record.external_system, external_id: @tmp_user_record.external_id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :from_external_system, format: "xml", external_system: @tmp_user_record.external_system, external_id: @tmp_user_record.external_id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should show by external system user record" do
    UserSession.create(@user)
    get :from_external_system, format: "json", external_system: @user_record.external_system, external_id: @user_record.external_id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    get :from_external_system, format: "xml", external_system: @user_record.external_system, external_id: @user_record.external_id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should show by external system existing tmp user record CORS json" do
    session[:tmp_user] = @tmp_user
    request.env['HTTP_ORIGIN'] = "https://#{Eshelf::EXAMPLE_ORIGIN}"
    get :from_external_system, format: "json", external_system: @tmp_user_record.external_system, external_id: @tmp_user_record.external_id
    assert_response :success
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
  end

  test "should show by external system new tmp user record CORS json" do
    request.env['HTTP_ORIGIN'] = "https://#{Eshelf::EXAMPLE_ORIGIN}"
    get :from_external_system, format: "json", external_system: 'primo'
    assert_response :success
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
  end

  test "should show by external system user record CORS json" do
    request.env['HTTP_ORIGIN'] = "https://#{Eshelf::EXAMPLE_ORIGIN}"
    UserSession.create(@user)
    get :from_external_system, format: "json", external_system: @user_record.external_system, external_id: @user_record.external_id
    assert_response :success
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
  end

  test "should destroy existing tmp user record" do
    session[:tmp_user] = @tmp_user
    assert_difference('@tmp_user.records.count', -1) do
      delete :destroy, id: @tmp_user_record
    end
    assert_redirected_to records_path
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy user record" do
    UserSession.create(@user)
    assert_difference('@user.records.count', -1) do
      delete :destroy, id: @user_record
    end
    assert_redirected_to records_path
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy multiple user record" do
    UserSession.create(@user)
    assert_difference('@user.records.count', -2) do
      delete :destroy, id: [@user_record, @user_record2]
    end
    assert_redirected_to records_path
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy existing tmp user record json" do
    session[:tmp_user] = @tmp_user
    assert_difference(['@tmp_user.records.count'], -1) do
      VCR.use_cassette('tmp user record becomes primo') do
        delete :destroy, format: "json", record: {
          external_id: @tmp_user_record.external_id, external_system: @tmp_user_record.external_system }
      end
    end
    assert_response :no_content
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy user record json" do
    UserSession.create(@user)
    assert_difference(['@user.records.count'], -1) do
      VCR.use_cassette('user record becomes primo') do
        delete :destroy, format: "json", record: {
          external_id: @user_record.external_id, external_system: @user_record.external_system }
      end
    end
    assert_response :no_content
    assert_nil response.headers['X-CSRF-Token']
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy existing tmp user record CORS json" do
    request.env['HTTP_ORIGIN'] = "https://#{Eshelf::EXAMPLE_ORIGIN}"
    session[:tmp_user] = @tmp_user
    assert_difference(['@tmp_user.records.count'], -1) do
      VCR.use_cassette('tmp user record becomes primo') do
        delete :destroy, format: "json", record: {
          external_id: @tmp_user_record.external_id, external_system: @tmp_user_record.external_system }
      end
    end
    assert_response :no_content
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should destroy user record CORS json" do
    request.env['HTTP_ORIGIN'] = "http://#{Eshelf::EXAMPLE_ORIGIN}"
    UserSession.create(@user)
    assert_difference(['@user.records.count'], -1) do
      VCR.use_cassette('user record becomes primo') do
        delete :destroy, format: "json", record: {
          external_id: @user_record.external_id, external_system: @user_record.external_system }
      end
    end
    assert_response :no_content
    assert_not_nil response.headers['X-CSRF-Token']
    assert_not_empty response.headers['X-CSRF-Token'].strip
    assert_equal 'Records successfully destroyed.', flash[:notice]
  end

  test "should return bad request for non whitelisted email format" do
    UserSession.create(@user)
    get :create_email, email_format: "bad_format", id: @user.records.collect{|record| record.id}
    assert_response :bad_request
  end

  test "should get records member new email form for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :new_email, id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: 1, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: "", type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "label[for=email_format]", {count: 1, text: "with format"}
        assert_select "select[name=email_format]" do |select_elements|
          assert_equal 1, select_elements.size
          select_elements.each do |select_element|
            assert_select "option", 3
          end
        end
      end
    end
  end

  test "should get records collection new email form for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :new_email, id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @tmp_user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: "", type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "label[for=email_format]", {count: 1, text: "with format"}
        assert_select "select[name=email_format]" do |select_elements|
          assert_equal 1, select_elements.size
          select_elements.each do |select_element|
            assert_select "option", 3
          end
        end
      end
    end
  end

  test "should get records collection new brief email form for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :new_email, email_format: "brief", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @tmp_user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: "", type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "brief", type: "hidden"}
      end
    end
  end

  test "should get records collection new medium email form for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :new_email, email_format: "medium", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @tmp_user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: "", type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "medium", type: "hidden"}
      end
    end
  end

  test "should get records collection new full email form for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :new_email, email_format: "full", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @tmp_user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: "", type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "full", type: "hidden"}
      end
    end
  end

  test "should get records member new email form for existing user" do
    UserSession.create(@user)
    get :new_email, id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: 1, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: @user.email, type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "label[for=email_format]", {count: 1, text: "with format"}
        assert_select "select[name=email_format]" do |select_elements|
          assert_equal 1, select_elements.size
          select_elements.each do |select_element|
            assert_select "option", 3
          end
        end
      end
    end
  end

  test "should get records collection new email form for existing user" do
    UserSession.create(@user)
    get :new_email, id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: @user.email, type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "label[for=email_format]", {count: 1, text: "with format"}
        assert_select "select[name=email_format]" do |select_elements|
          assert_equal 1, select_elements.size
          select_elements.each do |select_element|
            assert_select "option", 3
          end
        end
      end
    end
  end

  test "should get records collection new brief email form for existing user" do
    UserSession.create(@user)
    get :new_email, email_format: "brief", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: @user.email, type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "brief", type: "hidden"}
      end
    end
  end

  test "should get records collection new medium email form for existing user" do
    UserSession.create(@user)
    get :new_email, email_format: "medium", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: @user.email, type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "medium", type: "hidden"}
      end
    end
  end

  test "should get records collection new full email form for existing user" do
    UserSession.create(@user)
    get :new_email, email_format: "full", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "form#email_records" do |elements|
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select "input[name='id[]']", {count: @user.records.size, type: "hidden"}
        assert_select "label[for=to_address]", {count: 1, text: "Send to"}
        assert_select "input[name=to_address]", {count: 1, value: @user.email, type: "text"}
        assert_select "input[name=commit]", {count: 1, value: "Send", type: "submit"}
        assert_select "input[name=email_format]", {count: 1, value: "full", type: "hidden"}
      end
    end
  end

  test "should send records collection full email for existing tmp user" do
    session[:tmp_user] = @tmp_user
    post :create_email, to_address: "test@example.com", email_format: "full", id: @tmp_user.records.collect{|record| record.id}
    assert_redirected_to records_path
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should send records collection full email for existing user" do
    UserSession.create(@user)
    post :create_email, to_address: @user.email, email_format: "full", id: @user.records.collect{|record| record.id}
    assert_redirected_to records_path
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should return bad request for non whitelisted print format" do
    UserSession.create(@user)
    get :print, print_format: "bad_format", id: @user.records.collect{|record| record.id}
    assert_response :bad_request
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should get records member full print for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :print, print_format: "full", id: @tmp_user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should get records collection brief print for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :print, print_format: "brief", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should get records collection medium print for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :print, print_format: "medium", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should get records collection full print for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :print, print_format: "full", id: @tmp_user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should have title of BobCat Records" do
    UserSession.create(@user)
    get :print, print_format: "full", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat Records"
  end

  test "should get records member full print for existing user" do
    UserSession.create(@user)
    get :print, print_format: "full", id: @user_record.id
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat Records"
  end

  test "should get records collection brief print for existing user" do
    UserSession.create(@user)
    get :print, print_format: "brief", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat Records"
    assert_select "ul.records" do |elements|
      # We should only have 1 list
      assert_equal 1, elements.size
      elements.each do |element|
        assert_select element, "li" do |records_html|
          assert_equal @user.records.size, records_html.size
          assert_first_brief_print_record(records_html.first, @user.records.where(external_id: "nyu_aleph000570570").first)
          assert_last_brief_print_record(records_html.last, @user.records.where(external_id: "nyu_aleph000980206").first)
        end
      end
    end
  end

  test "should get records collection medium print for existing user" do
    UserSession.create(@user)
    get :print, print_format: "medium", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat Records"
  end

  test "should get records collection full print for existing user" do
    UserSession.create(@user)
    get :print, print_format: "full", id: @user.records.collect{|record| record.id}
    assert_response :success
    assert_nil response.headers['X-CSRF-Token']
    assert_select "title", "BobCat Records"
  end

  test "should redirect to record url for existing tmp user" do
    session[:tmp_user] = @tmp_user
    get :getit, id: @tmp_user_record.id
    assert_redirected_to "https://getit.library.nyu.edu/nyu/resolve?#{@tmp_user_record.url}"
    assert_nil response.headers['X-CSRF-Token']
  end

  test "should redirect to record url for existing user" do
    UserSession.create(@user)
    get :getit, id: @user_record.id
    assert_redirected_to "https://getit.library.nyu.edu/nyu/resolve?#{@user_record.url}"
    assert_nil response.headers['X-CSRF-Token']
  end

  def assert_first_brief_print_record(element, record)
    assert_equal("<li>\n      "+
      "<p><strong>Travels with my aunt [videorecording] (video)</strong></p>"+
      "<p>Locations: NYU Bobst Avery Fisher Center Main Collection</p>"+
      "<p>#{record_getit_url(record)}</p>\n    </li>", element.to_s)
  end

  def assert_last_brief_print_record(element, record)
    assert_equal("<li>\n      "+
      "<p><strong>Virtual inequality : beyond the digital divide (book)</strong></p>"+
      "<p><div>Locations:</div>"+
      "<div class=\"location\">NYU Bobst Main Collection (HN49.I56 M67 2003 )</div>"+
      "<div class=\"location\">New School Fogelman Library Main Collection (HN49.I56 M67 2003 )</div></p>"+
      "<p>#{record_getit_url(record)}</p>\n    </li>", element.to_s)
  end
end
