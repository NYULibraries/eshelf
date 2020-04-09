require 'rails_helper'

describe Eshelf::Citation, :vcr do
  let(:primo_id) { 'nyu_aleph006048386' }
  let(:citation) { Eshelf::Citation.new(primo_id) }
  let(:format) { 'ris' }
  let(:calling_system) { nil }
  let(:institution) { nil }

  describe '.cite_url', :vcr do
    subject { Eshelf::Citation.cite_url(format: format) }
    context 'when RIS is passed in as the format' do
      it { is_expected.to include "#{ENV['CITE_URL']}?calling_system=primo&institution=NYU&cite_to=ris" }
    end
    context 'when NYSID is passed in as the institution' do
      subject { Eshelf::Citation.cite_url(format: format, institution: 'NYSID') }
      it { is_expected.to include "#{ENV['CITE_URL']}?calling_system=primo&institution=NYSID&cite_to=ris" }
    end
    context 'when /openurl is passed in as the cite_url' do
      subject { Eshelf::Citation.cite_url(format: format, cite_url: '/openurl') }
      it { is_expected.to eql '/openurl?calling_system=primo&institution=NYU&cite_to=ris' }
    end
  end

  describe '#to_json', :vcr do
    subject { citation.to_json }
    it { is_expected.to be_a String }
    it { is_expected.to include %Q({\"#{primo_id}\":{\"itemType\":\"book\") }
  end

  describe '#openurl', :vcr do
    subject { citation.openurl }
    it { is_expected.to include 'getit.library.nyu.edu/resolve?&ctx_ver=Z39.88-2004&ctx_enc=info:ofi/enc:UTF-8' }
  end

  describe '#get_citation', :vcr do
    subject { citation.send(:get_citation) }

    context 'when no external_id is passed' do
      let(:primo_id) { nil }
      it { is_expected.to be_nil }
    end

    context 'when a valid external_id is passed' do
      its(:code) { is_expected.to eql 200 }
    end
  end

  describe '#record', :vcr do
    subject { citation.record }
    its(["addau"]) { is_expected.to eql ["Jacobson, Gary C., author", "Kousser, Thad, 1974- author", "Vavreck, Lynn, 1968- author"] }
    its(["author"]) { is_expected.to eql "Kernell, Samuel, 1945- author" }
    its(["contributor"]) { is_expected.to eql ["Jacobson, Gary C., author", "Kousser, Thad, 1974- author", "Vavreck, Lynn, 1968- author"] }
    its(["date"]) { is_expected.to eql "2018" }
    its(["importedFrom"]) { is_expected.to eql "PNX_JSON" }
    its(["institution"]) { is_expected.to eql "NYU" }
    its(["isbn"]) { is_expected.to eql ["9781506358666", "1506358667"] }
    its(["itemType"]) { is_expected.to eql "book" }
    its(["language"]) { is_expected.to eql "eng" }
    its(["links"]) { is_expected.to be_instance_of Hash }
    its(["locations"]) { is_expected.to eql ["NYU Bobst  Main Collection  (JK276 .K47 2018 )"] }
    its(["notes"]) { is_expected.to eql "Includes bibliographical references and index." }
    its(["oclcnum"]) { is_expected.to eql "968690236" }
    its(["place"]) { is_expected.to eql "Thousand Oaks, California" }
    its(["pnxRecordId"]) { is_expected.to eql "nyu_aleph006048386" }
    its(["publisher"]) { is_expected.to eql "SAGE, CQ Press" }
    its(["subject"]) { is_expected.to eql ["Politics and government", "United States–Politics and government Textbooks", "United States"] }
    its(["tags"]) { is_expected.to eql ["Politics and government", "United States–Politics and government Textbooks", "United States"] }
    its(["title"]) { is_expected.to eql "The logic of American politics" }
  end


end
