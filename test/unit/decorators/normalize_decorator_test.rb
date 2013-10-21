# encoding: UTF-8
require 'test_helper'

class NormalizeDecoratorTest < ActiveSupport::TestCase
  setup do
    @record = records(:user_primo_record1)
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    @normalized_record = RecordDecorator::NormalizeDecorator.new(@record)
  end

  test "normalize title" do
    assert_equal "Virtual inequality : beyond the digital divide (book)", @normalized_record.title
  end

  test "normalize url" do
    assert_not_equal "getit/#{@record.id}", @record.url
    assert_equal @record.url, RecordDecorator::NormalizeDecorator.new(@record).url
    assert_equal "getit/#{@record.id}", RecordDecorator::NormalizeDecorator.new(@record, MockRecordDecoratorViewContext.new).url
  end

  test "normalize author" do
    assert_equal "Karen Mossberger; Mary Stansbury 1957-; Caroline J Tolbert", 
      @normalized_record.author, "Unexpected author"
  end

  test "should have author only" do
    normalized_author_record = RecordDecorator::NormalizeDecorator.new(records(:creator_primo_record))
    assert_equal "Barbara Jean  Monroe  1948-", normalized_author_record.author, "Unexpected author for Primo author only"
  end

  test "should have contributor only" do
    normalized_contributor_record = RecordDecorator::NormalizeDecorator.new(records(:contributor_primo_record))
    assert_equal "Fay Patel", normalized_contributor_record.author, "Unexpected author for Primo contributor only"
  end

  test "should not have author" do
    normalized_authorless_record = RecordDecorator::NormalizeDecorator.new(records(:authorless_primo_record))
    assert_nil normalized_authorless_record.author, "Expected author to be nil for authorless Primo record"
  end

  test "normalize publisher" do
    assert_equal "Georgetown University Press", @normalized_record.publisher, "Unexpected publisher"
  end

  test "normalize city of publication" do
    assert_equal "Washington, D.C.", @normalized_record.city_of_publication, "Unexpected city of publication"
  end

  test "normalize date of publication" do
    assert_equal "2003; c2003", @normalized_record.date_of_publication, "Unexpected date of publication"
  end

  test "normalize journal title" do
    assert_nil @normalized_record.journal_title, "Unexpected journal title"
  end

  test "normalize subjects" do
    assert_equal "GDD (Global digital divide); Digital divide; Global digital divide; Divide, Digital", @normalized_record.subjects, "Unexpected subjects"
  end

  test "normalize issn" do
    assert_nil @normalized_record.issn, "Unexpected issn"
  end

  test "normalize eissn" do
    assert_nil @normalized_record.eissn, "Unexpected eissn"
  end

  test "normalize isbn" do
    assert_equal "0878409998; 9780878409990", @normalized_record.isbn, "Unexpected isbn"
  end

  test "normalize related titles" do
    assert_nil @normalized_record.related_titles, "Unexpected related titles"
  end

  test "normalize language" do
    assert_equal "eng", @normalized_record.language, "Unexpected language"
  end

  test "normalize description" do
    assert_equal "xvi, 192 p. ; 22 cm.", @normalized_record.description, "Unexpected description"
  end

  test "normalize notes" do
    assert_nil @normalized_record.notes, "Unexpected notes"
  end
end
