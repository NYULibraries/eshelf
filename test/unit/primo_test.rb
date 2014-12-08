# encoding: UTF-8
require 'test_helper'

class PrimoTest < ActiveSupport::TestCase
  setup do
    @record = FactoryGirl.build(:user_primo_record1)
  end

  test "new nokogiri xml document" do
    assert_nothing_raised("New Nokogiri::XML::Document raises an error.") {
      Nokogiri::XML::Document.new
    }
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
    assert_equal("rft.ulr_ver=Z39.88-2004&rft.ctx_ver=Z39.88-2004&rft.rfr_id=info:sid/primo.exlibrisgroup.com:primo-nyu_aleph000980206&rft_val_fmlt=info:ofi/fmt:kev:mtx:book&rft.genre=book&rft.au=Karen+Mossberger&rft.contributor=Mary+Stansbury+1957-&rft.contributor=Caroline+J+Tolbert&rft.publisher=Georgetown+University+Press&rft.place=Washington%2C+D.C.&rft.tpages=192&rft_id=urn:isbn:0878409998&rft.isbn=0878409998&rft.btitle=Virtual+inequality+%3A+beyond+the+digital+divide&rft.date=2003",
      @record.url)
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

  test "to bibtex" do
    assert_nothing_raised do
      VCR.use_cassette('record becomes primo') do
        @record.becomes_external_system.save
      end
      @record.to_bibtex
    end
  end

  test "to ris" do
    assert_nothing_raised do
      VCR.use_cassette('record becomes primo') do
        @record.becomes_external_system.save
      end
      @record.to_ris
    end
  end
end
