# encoding: UTF-8
require 'test_helper'

class ArticleDecoratorTest < ActiveSupport::TestCase
  setup do
    VCR.use_cassette('record becomes primo') do
      @record = FactoryBot.build(:user_primo_record1)
      # @record.becomes_external_system.save
    end
    @normalized_record = RecordDecorator::NormalizeDecorator.new(@record, MockRecordDecoratorViewContext.new())
    @labeled_record = RecordDecorator::LabelDecorator.new(@normalized_record)
    @brief_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "brief")
    @medium_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "medium")
    @full_citation_record = RecordDecorator::CitationDecorator.new(@labeled_record, "full")
  end

  test "brief article attributes" do
    article_record = RecordDecorator::ArticleDecorator.new(@brief_citation_record)
    assert_equal ["title", "journal_title", "url", "locations"], article_record.citation_attributes, "Unexpected brief attributes"
  end

  test "medium article attributes" do
    article_record = RecordDecorator::ArticleDecorator.new(@medium_citation_record)
    assert_equal ["title", "journal_title", "url", "locations", "author", "publisher",
      "city_of_publication", "date_of_publication"], article_record.citation_attributes,
        "Unexpected medium attributes"
  end

  test "full article attributes" do
    article_record = RecordDecorator::ArticleDecorator.new(@full_citation_record)
    assert_equal ["title", "journal_title", "url", "locations", "author", "publisher",
      "city_of_publication", "date_of_publication", "subjects", "issn", "eissn",
        "isbn", "related_titles", "language", "description", "notes"],
          article_record.citation_attributes, "Unexpected full attributes"
  end
end
