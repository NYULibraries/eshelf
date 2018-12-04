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
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYU&cite_to=ris' }
    end
    context 'when NYSID is passed in as the institution' do
      subject { Eshelf::Citation.cite_url(format: format, institution: 'NYSID') }
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYSID&cite_to=ris' }
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
    it { is_expected.to include 'https://qa.getit.library.nyu.edu/resolve?&ctx_ver=Z39.88-2004&ctx_enc=info:ofi/enc:UTF-8' }
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

end
