require 'rails_helper'

describe Primo do
  let(:record) { build(:user_primo_record1) }
  let(:primo_record) { record.becomes_external_system }

  describe '#becomes_external_system', :vcr do
    subject { primo_record }
    its(:external_id) { is_expected.to eql 'nyu_aleph000980206' }
    its(:external_system) { is_expected.to eql 'primo' }
    its(:format) { is_expected.to eql 'pnx_json' }
    its(:title) { is_expected.to eql 'Virtual inequality : beyond the digital divide' }
    its(:author) { is_expected.to eql 'Mossberger, Karen; Tolbert, Caroline J; Stansbury, Mary, 1957-' }
    its(:title_sort) { is_expected.to eql 'Virtual inequality : beyond the digital divide' }
    its(:content_type) { is_expected.to eql 'book' }
    its(:url) { is_expected.to include 'rfr_id=info:sid/primo.exlibrisgroup.com:primo-nyu_aleph00098020' }

    context 'when record has special characters' do
      before do
        @record_with_special_chars = Record.new(external_system: 'primo', external_id: 'nyu_aleph006908640').becomes_external_system
        @record_with_special_chars.save
      end
      subject { @record_with_special_chars }
      its(:author) { is_expected.to include 'Pedró, Francesc' }
    end

    describe '#primo_locations' do
      let(:primo_locations) { primo_record.primo_locations }
      it 'should have two items' do
        expect(primo_locations.size).to eql 2
      end
      subject { primo_location }
      context 'when it is the first location' do
        let(:primo_location) { primo_locations.first }
        its([:collection]) { is_expected.to eql 'NYU Bobst Main Collection' }
        its([:call_number]) { is_expected.to eql 'HN49.I56 M67 2003' }
      end
      context 'when it is the first location' do
        let(:primo_location) { primo_locations.last }
        its([:collection]) { is_expected.to eql 'NYU New School Main Collection' }
        its([:call_number]) { is_expected.to eql 'HN49.I56 M67 2003' }
      end
        
    end
  end

end