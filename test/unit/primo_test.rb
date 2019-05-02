# encoding: UTF-8
require 'test_helper'

class PrimoTest < ActiveSupport::TestCase
  setup do
    @record = FactoryBot.build(:user_primo_record1)
  end

  test "new nokogiri xml document" do
    assert_nothing_raised do
      Nokogiri::XML::Document.new
    end
  end

  test "becomes external system" do
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    assert_equal("nyu_aleph000980206", @record.external_id)
    assert_equal("primo", @record.external_system)
    assert_equal("pnx", @record.format)
    assert_equal("Virtual inequality : beyond the digital divide", @record.title)
    assert_equal("Mossberger, Karen; Tolbert, Caroline J; Stansbury, Mary, 1957-", @record.author)
    assert_equal("Virtual inequality : beyond the digital divide /", @record.title_sort)
    assert_equal("book", @record.content_type)
    assert_includes(@record.url, "rfr_id=info:sid/primo.exlibrisgroup.com:primo-nyu_aleph000980206")
  end

  test "primo record with special chars" do
    primo_record_with_special_chars = Record.new
    primo_record_with_special_chars.external_system = "primo"
    primo_record_with_special_chars.external_id = "nyu_aleph003376830"
    VCR.use_cassette('primo record with special chars') do
      primo_record_with_special_chars.becomes_external_system.save
    end
    assert_equal("Pedró, Francesc; Programme for International Student Assessment; "+
      "Centre for Educational Research and Innovation; Organisation for Economic Co-operation and Development; "+
        "SourceOECD (Online service)", primo_record_with_special_chars.author)
  end

  test "locations" do
    VCR.use_cassette('record becomes primo') do
      @record.becomes_external_system.save
    end
    assert_equal 2, @record.locations.size, "Unexpected locations size"
    assert_equal "NYU Bobst Main Collection",
      @record.locations.first.collection, "Unexpected first location collection"
    assert_equal "(HN49.I56 M67 2003 )", @record.locations.first.call_number  ,
        "Unexpected first location call number"
    assert_equal "New School Fogelman Library Main Collection",
      @record.locations.last.collection, "Unexpected last location collection"
    assert_equal "(HN49.I56 M67 2003 )", @record.locations.last.call_number,
      "Unexpected last location call number"
  end

end
