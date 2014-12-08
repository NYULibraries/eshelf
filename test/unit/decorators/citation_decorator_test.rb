# encoding: UTF-8
require 'test_helper'

class CitationDecoratorTest < ActiveSupport::TestCase
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

  test "should return nil citation attributes for nil format" do
    assert_nil RecordDecorator::CitationDecorator.new(@labeled_record, nil).citation_attributes,
      "Unexpected nil format attributes"
  end

  test "should return nil citation attributes for unknown format" do
    assert_nil RecordDecorator::CitationDecorator.new(@labeled_record, "unknown").citation_attributes,
      "Unexpected unknown format attributes"
  end

  test "brief citation attributes" do
    assert_equal ["title", "url", "locations"], @brief_citation_record.citation_attributes, "Unexpected brief attributes"
  end

  test "medium citation attributes" do
    assert_equal ["title", "url", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title"], @medium_citation_record.citation_attributes,
        "Unexpected medium attributes"
  end

  test "full citation attributes" do
    assert_equal ["title", "url", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title", "subjects", "issn", "eissn", "isbn",
        "related_titles", "language", "description", "notes"],
          @full_citation_record.citation_attributes, "Unexpected full attributes"
  end
end
