require 'test_helper'
class RecordsHelperTest < ActionView::TestCase
  # Added for sort options
  attr_reader :request

  setup do
    # Need to set the request where the sorted gem expects it
    @request ||= @controller.request
    @user_record = FactoryGirl.build(:user_record)
    @tmp_user_record = FactoryGirl.build(:tmp_user_record)
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
    assert_equal "<input id=\"select\" name=\"select\" type=\"checkbox\" value=\"1\" />", select_title
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

  test "should return array of refwork, endnote, easybib, ris, bibtext for export options" do
    assert_kind_of Array, export_options
    assert_equal 5, export_options.size
    assert_dom_equal "<a href=\"/export_citations/refworks\" id=\"refworks\" target=\"_blank\">Push to RefWorks</a>", export_options[0]
    assert_dom_equal "<a href=\"/export_citations/endnote\" id=\"endnote\" target=\"_blank\">Push to EndNote</a>", export_options[1]
    assert_dom_equal "<a href=\"/export_citations/easybibpush\" id=\"easybib\" target=\"_blank\">Push to EasyBib</a>", export_options[2]
    assert_dom_equal "<a href=\"/records.ris\" id=\"ris\" target=\"_blank\">Download as RIS</a>", export_options[3]
    assert_dom_equal "<a href=\"/records.bibtex\" id=\"bibtex\" target=\"_blank\">Download as BibTex</a>", export_options[4]
  end

  test "should return array of 10, 20, 50, 100 for per page options" do
    assert_kind_of Array, per_page_options
    assert_equal 4, per_page_options.size
    assert_dom_equal '<a href="/records?per=10">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?per=20">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?per=50">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?per=100">100</a>', per_page_options[3]
  end

  test "should return array of 10, 20, 50, 100 with merged book content type for per page options" do
    params[:content_type] = "book"
    assert_dom_equal '<a href="/records?content_type=book&amp;per=10">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?content_type=book&amp;per=20">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?content_type=book&amp;per=50">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?content_type=book&amp;per=100">100</a>', per_page_options[3]
  end

  test "should return array of 10, 20, 50, 100 with merged ids type for per page options" do
    params[:id] = ["1", "2"]
    assert_dom_equal '<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=10">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=20">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=50">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=100">100</a>', per_page_options[3]
  end

  test "should return array of 10, 20, 50, 100 with merged tag 'test tag' for per page options" do
    params[:tag] = "test tag"
    assert_dom_equal '<a href="/records?per=10&amp;tag=test+tag">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?per=20&amp;tag=test+tag">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?per=50&amp;tag=test+tag">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?per=100&amp;tag=test+tag">100</a>', per_page_options[3]
  end

  test "should return array of 10, 20, 50, 100 with merged title sort asc for per page options" do
    params[:sort] = "title_sort_asc"
    assert_dom_equal '<a href="/records?per=10&amp;sort=title_sort_asc">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?per=20&amp;sort=title_sort_asc">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?per=50&amp;sort=title_sort_asc">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?per=100&amp;sort=title_sort_asc">100</a>', per_page_options[3]
  end

  test "should return array of 10, 20, 50, 100 with merged title sort asc and tag 'test tag' for per page options" do
    params[:tag] = "test tag"
    params[:sort] = "title_sort_asc"
    assert_dom_equal '<a href="/records?per=10&amp;sort=title_sort_asc&amp;tag=test+tag">10</a>', per_page_options[0]
    assert_dom_equal '<a href="/records?per=20&amp;sort=title_sort_asc&amp;tag=test+tag">20</a>', per_page_options[1]
    assert_dom_equal '<a href="/records?per=50&amp;sort=title_sort_asc&amp;tag=test+tag">50</a>', per_page_options[2]
    assert_dom_equal '<a href="/records?per=100&amp;sort=title_sort_asc&amp;tag=test+tag">100</a>', per_page_options[3]
  end

  # This was WAY too hard to figure out.
  # Need to set params for routes and need to include the helper module
  include Sorted::ViewHelpers::ActionView
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
