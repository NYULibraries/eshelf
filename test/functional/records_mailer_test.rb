require 'test_helper'

class RecordsMailerTest < ActionMailer::TestCase
  setup do
    @user = FactoryBot.create(:user)
    VCR.use_cassette('record becomes primo', :record => :new_episodes) do
      @records = [FactoryBot.build(:user_primo_record1, user: @user)]
      @records << FactoryBot.build(:user_primo_record2, user: @user)
      # @records.each do |record|
      #   record.becomes_external_system.save!
      # end
    end
    @alternative_email = "test@library.edu"
  end

  def test_email_not_whitelisted_format
    exception = assert_raise(ArgumentError) {
      email = RecordsMailer.records_email(@user, @records, "not_whitelisted").deliver_now
    }
    assert_equal "Unknown format", exception.message
  end

  def test_email_no_specified_email_brief
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "brief").deliver_now
    assert_subject_email(@user.email, email)
    assert_brief_email_body(email)
  end

  def test_email_specified_email_brief
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "brief", @alternative_email).deliver_now
    assert_subject_email(@alternative_email, email)
    assert_brief_email_body(email)
  end

  def test_email_no_specified_email_medium
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "medium").deliver_now
    assert_subject_email(@user.email, email)
    # assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end

  def test_email_specified_email_medium
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "medium", @alternative_email).deliver_now
    assert_subject_email(@alternative_email, email)
    # assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end

  def test_email_no_specified_email_full
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "full").deliver_now
    assert_subject_email(@user.email, email)
    # assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end

  def test_email_specified_email_full
    # Send the email, then test that it got queued
    email = RecordsMailer.records_email(@user, @records, "full", @alternative_email).deliver_now
    assert_subject_email(@alternative_email, email)
    # assert_match(/Welcome to example.com, #{user.name}/, email.encoded)
  end

  def assert_subject_email(expected_to, actual_email)
    assert !ActionMailer::Base.deliveries.empty?
    # Test that the sent email contains what we expect it to
    assert_equal [expected_to], actual_email.to
    assert_equal "BobCat results", actual_email.subject
  end
  private :assert_subject_email

  def assert_brief_email_body(email)
    assert_equal("Virtual inequality : beyond the digital divide (book)\n"+
      "Locations: \n"+
      "\tNYU Bobst Main Collection HN49.I56 M67 2003\n"+
      "\tNew School Offsite Main Collection HN49.I56 M67 2003\n\n"+
      "===\n"+
      "Travels with my aunt [videorecording] (videorecording)\n"+
      "Locations: NYU Bobst Avery Fisher Center Main Collection VCA 15583\n\n"+
      "===\n", email.body.to_s)
  end

  def record_getit_url(record)
    "https://eshelf.library.nyu.edu/records/#{record.id}/getit"
  end
end
