# encoding: UTF-8
require 'test_helper'

class EmailDecoratorTest < ActiveSupport::TestCase
  setup do
    @record = FactoryGirl.build(:user_primo_record1)
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    @normalized_record = RecordDecorator::NormalizeDecorator.new(@record, MockRecordDecoratorViewContext.new())
    @labeled_record = RecordDecorator::LabelDecorator.new(@normalized_record)
    @brief_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "brief")
    @medium_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "medium")
    @full_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "full")
  end

  test "brief email attributes" do
    email_record = RecordDecorator::EmailDecorator.new(@brief_citation_record)
    assert_equal ["title", "url", "locations"], email_record.citation_attributes, "Unexpected brief attributes"
  end

  test "medium email attributes" do
    email_record = RecordDecorator::EmailDecorator.new(@medium_citation_record)
    assert_equal ["title", "url", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title"], email_record.citation_attributes,
        "Unexpected medium attributes"
  end

  test "full email attributes" do
    email_record = RecordDecorator::EmailDecorator.new(@full_citation_record)
    assert_equal ["title", "url", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title", "subjects", "issn", "eissn", "isbn",
        "related_titles", "language", "description", "notes"],
          email_record.citation_attributes, "Unexpected full attributes"
  end

  test "email url" do
    email_record = RecordDecorator::EmailDecorator.new(@brief_citation_record)
    assert_equal "getit/#{@record.id}", @labeled_record.url, "Unexpected url"
  end

end
