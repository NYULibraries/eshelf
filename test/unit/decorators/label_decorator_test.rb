# encoding: UTF-8
require 'test_helper'

class LabelDecoratorTest < ActiveSupport::TestCase
  setup do
    @record = records(:user_primo_record1)
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    @xerxes_record = records(:user_xerxes_record1)
    @xerxes_record.becomes_external_system.save
    @normalized_record = RecordDecorator::NormalizeDecorator.new(@record, MockRecordDecoratorViewContext.new())
    @labeled_record = RecordDecorator::LabelDecorator.new(@normalized_record)
    @normalized_xerxes_record = RecordDecorator::NormalizeDecorator.new(@xerxes_record)
    @labeled_xerxes_record = RecordDecorator::LabelDecorator.new(@normalized_xerxes_record)
  end

  test "label url" do
    assert_equal "getit/#{@record.id}", @labeled_record.url, "Unexpected url"
  end

  test "locations label" do
    assert_equal "Locations:", @labeled_record.locations_label, "Unexpected primo locations"
    assert_equal "Call number:", @labeled_xerxes_record.locations_label, "Unexpected xerxes locations"
  end

  test "label author" do
    assert_equal "Author: Karen Mossberger; Mary Stansbury 1957-; Caroline J Tolbert", @labeled_record.author, "Unexpected author"
  end

  test "label publisher" do
    assert_equal "Publisher: Georgetown University Press", @labeled_record.publisher, "Unexpected publisher"
  end

  test "label city of publication" do
    assert_equal "City of Publication: Washington, D.C.", @labeled_record.city_of_publication, "Unexpected publisher"
  end

  test "label date of publication" do
    assert_equal "Date of Publication: 2003; c2003", @labeled_record.date_of_publication, "Unexpected publisher"
  end

  test "label journal title" do
    assert_nil @labeled_record.journal_title, "Unexpected journal title"
  end

  test "label subjects" do
    assert_equal "Subjects: GDD (Global digital divide); Digital divide; Global digital divide; Divide, Digital", @labeled_record.subjects, "Unexpected subjects"
  end

  test "label issn" do
    assert_nil @labeled_record.issn, "Unexpected issn"
  end

  test "label eissn" do
    assert_nil @labeled_record.eissn, "Unexpected eissn"
  end

  test "label isbn" do
    assert_equal "ISBN: 0878409998; 9780878409990", @labeled_record.isbn, "Unexpected isbn"
  end

  test "label related titles" do
    assert_nil @labeled_record.related_titles, "Unexpected related titles"
  end

  test "label language" do
    assert_equal "Language: eng", @labeled_record.language, "Unexpected language"
  end

  test "label description" do
    assert_equal "Description: xvi, 192 p. ; 22 cm.", @labeled_record.description, "Unexpected description"
  end

  test "label notes" do
    assert_nil @labeled_record.notes, "Unexpected notes"
  end
end
