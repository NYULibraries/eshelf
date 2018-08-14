require 'rails_helper'

describe Eshelf::PnxJson, :vcr do
  let(:primo_id) { 'nyu_aleph006048386' }
  let(:pnx_json) { Eshelf::PnxJson.new(primo_id) }

  describe "#parsed_json_record", :vcr do
    subject { pnx_json.parsed_json_record }
    it { is_expected.to be_a Hash }
    it "should have a @TYPE of book" do
      expect(subject["@TYPE"]).to eql "book"
    end
  end

  describe "#openurl", :vcr do
    subject { pnx_json.openurl }
    it { is_expected.to include "rft.primo=#{primo_id}" }
  end

end
