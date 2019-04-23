require 'test_helper'
class RecordsHelperTest < ActionView::TestCase
  # Added for sort options
  attr_reader :request

  setup do
    # Need to set the request where the sorted gem expects it
    @request ||= @controller.request
    @user_record = FactoryBot.build(:user_record)
    @tmp_user_record = FactoryBot.build(:tmp_user_record)
  end

  test "should return an array of printable records" do
    printable_records([@user_record, @tmp_user_record], "brief").each do |print_record|
      assert_kind_of RecordDecorator::PrintDecorator, print_record
    end
  end

  test "should return a printable record" do
    assert_kind_of RecordDecorator::PrintDecorator, printable_record(@user_record, "brief")
    assert_kind_of RecordDecorator::PrintDecorator, printable_record(@user_record, "medium")
    assert_kind_of RecordDecorator::PrintDecorator, printable_record(@user_record, "full")
  end

  test "should return a checkbox for select title" do
    assert_equal "<input type=\"checkbox\" name=\"select\" id=\"select\" value=\"1\" />", select_title
  end

  test "should return an array of select options" do
    assert_kind_of Array, select_options
    assert_equal 2, select_options.size
    assert_dom_equal "<a href=\"/records\" class=\"select-all\">All</a>", select_options[0]
    assert_dom_equal "<a href=\"/records\" class=\"select-none\">None</a>", select_options[1]
  end

  test "should return array of brief, medium, full for email options" do
    assert_kind_of Array, email_options
    assert_equal 3, email_options.size
    modal_attributes = "class=\"email\" data-target=\"#modal\" data-toggle=\"modal\""
    assert_dom_equal "<a href=\"/records/email/new/brief\" #{modal_attributes}>Brief</a>", email_options[0]
    assert_dom_equal "<a href=\"/records/email/new/medium\" #{modal_attributes}>Medium</a>", email_options[1]
    assert_dom_equal "<a href=\"/records/email/new/full\" #{modal_attributes}>Full</a>", email_options[2]
  end

  test "should return option tags string for email options select box" do
    assert_equal "<option value=\"brief\">Brief</option>\n<option value=\"medium\">Medium</option>\n<option value=\"full\">Full</option>", email_options_for_select
  end

  test "should return array of [Brief, brief], [Medium, medium], [Full, full] for email options collection" do
    assert_kind_of Array, email_options_collection
    assert_equal 3, email_options_collection.size
    assert_equal ["Brief", "brief"], email_options_collection[0]
    assert_equal ["Medium", "medium"], email_options_collection[1]
    assert_equal ["Full", "full"], email_options_collection[2]
  end

  test "should return array of brief, medium, full for print options" do
    assert_kind_of Array, print_options
    assert_equal 3, print_options.size
    assert_dom_equal "<a href=\"/records/print/brief\" class=\"print\" target=\"_blank\">Brief</a>", print_options[0]
    assert_dom_equal "<a href=\"/records/print/medium\" class=\"print\" target=\"_blank\">Medium</a>", print_options[1]
    assert_dom_equal "<a href=\"/records/print/full\" class=\"print\" target=\"_blank\">Full</a>", print_options[2]
  end

  # This was WAY too hard to figure out.
  # Need to set params for routes and need to include the helper module
  # include Sorted::ViewHelpers::ActionView
  test "should return array of created at, title, author for sort options" do
    # Set up params for the sorted gem
    params[:controller] = "records"
    params[:action] = "index"
    assert_kind_of Array, sort_options
    assert_equal 3, sort_options.size
    assert_dom_equal '<a href="/records?sort=created_at_asc" class="sorted">date added</a>', sort_options[0]
    assert_dom_equal '<a href="/records?sort=title_sort_asc" class="sorted">title</a>', sort_options[1]
    assert_dom_equal '<a href="/records?sort=author_asc" class="sorted">author</a>', sort_options[2]
  end

  test "should return array of created at desc, title, author for sort options" do
    # Set up params for the sorted gem
    params[:controller] = "records"
    params[:action] = "index"
    params[:sort] = "created_at_asc"
    assert_kind_of Array, sort_options
    assert_equal 3, sort_options.size
    assert_dom_equal '<a href="/records?sort=created_at_desc" class="sorted asc">date added</a>', sort_options[0]
    assert_dom_equal '<a href="/records?sort=title_sort_asc%21created_at_asc" class="sorted">title</a>', sort_options[1]
    assert_dom_equal '<a href="/records?sort=author_asc%21created_at_asc" class="sorted">author</a>', sort_options[2]
  end

  test "should return array of created at, title desc, author for sort options" do
    # Set up params for the sorted gem
    params[:controller] = "records"
    params[:action] = "index"
    params[:sort] = "title_sort_asc"
    assert_kind_of Array, sort_options
    assert_equal 3, sort_options.size
    assert_dom_equal '<a href="/records?sort=created_at_asc%21title_sort_asc" class="sorted">date added</a>', sort_options[0]
    assert_dom_equal '<a href="/records?sort=title_sort_desc" class="sorted asc">title</a>', sort_options[1]
    assert_dom_equal '<a href="/records?sort=author_asc%21title_sort_asc" class="sorted">author</a>', sort_options[2]
  end
end
