# encoding: UTF-8
require 'test_helper'

class PrintDecoratorTest < ActiveSupport::TestCase
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

  test "print view context inheritance" do
    print_record = RecordDecorator::PrintDecorator.new(@brief_citation_record)
    assert_not_nil print_record.view_context
  end

  test "print title" do
    print_record = RecordDecorator::PrintDecorator.new(@brief_citation_record)
    assert_equal "<strong>Virtual inequality : beyond the digital divide (book)</strong>", print_record.title
  end

  test "brief print attributes" do
    print_record = RecordDecorator::PrintDecorator.new(@brief_citation_record)
    assert_equal ["title", "locations", "url"], print_record.citation_attributes, "Unexpected brief attributes"
  end

  test "medium print attributes" do
    print_record = RecordDecorator::PrintDecorator.new(@medium_citation_record)
    assert_equal ["title", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title", "url"], print_record.citation_attributes,
        "Unexpected medium attributes"
  end

  test "full print attributes" do
    print_record = RecordDecorator::PrintDecorator.new(@full_citation_record)
    assert_equal ["title", "locations", "author", "publisher", "city_of_publication",
      "date_of_publication", "journal_title", "subjects", "issn", "eissn", "isbn",
        "related_titles", "language", "description", "notes", "url"],
          print_record.citation_attributes, "Unexpected full attributes"
  end
end
