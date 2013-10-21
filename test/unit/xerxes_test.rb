# encoding: UTF-8
require 'test_helper'

class XerxesTest < ActiveSupport::TestCase
  setup do
    @record = records(:user_xerxes_record1)
  end

  test "new nokogiri xml document" do
    assert_nothing_raised("New Nokogiri::XML::Document raises an error.") {
      Nokogiri::XML::Document.new
    }
  end

  test "becomes external system" do
    assert @record.becomes_external_system.save
    assert_equal("xerxes1", @record.external_id)
    assert_equal("xerxes", @record.external_system)
    assert_equal("xerxes_xml", @record.format)
    assert_equal("A Place for Hemingway", @record.title)
    # assert_equal("", @record.author)
    # assert_equal("", @record.title_sort)
    assert_equal("article", @record.content_type)
    # assert_equal("", @record.url)
  end

  test "locations" do
    assert @record.becomes_external_system.save
    assert_equal 1, @record.locations.size, "Unexpected locations size"
    assert_nil @record.locations.first.collection, 
      "Unexpected first location collection"
    assert_equal "(Dummy Call Number)", 
      @record.locations.first.call_number, "Unexpected first locations call number"
  end

  test "to bibtex" do
    assert_nothing_raised do
      @record.becomes_external_system.save!
      # @record.to_bibtex
    end
  end

  test "to ris" do
    assert_nothing_raised do
      @record.becomes_external_system.save!
      # @record.to_ris
    end
  end
end
