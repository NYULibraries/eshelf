require 'rails_helper'

describe Primo do
  let(:record) { build(:user_primo_record1) }

  describe '#becomes_external_system', :vcr do
    before do
      @record = record.becomes_external_system
      @record.save
    end
    subject { @record }
    its(:external_id) { is_expected.to eql 'nyu_aleph000980206' }
    its(:external_system) { is_expected.to eql 'primo' }
    its(:format) { is_expected.to eql 'pnx' }
    its(:title) { is_expected.to eql 'Virtual inequality : beyond the digital divide' }
    its(:author) { is_expected.to eql 'Mossberger, Karen; Tolbert, Caroline J; Stansbury, Mary, 1957-' }
    its(:title_sort) { is_expected.to eql 'Virtual inequality : beyond the digital divide /' }
    its(:content_type) { is_expected.to eql 'book' }
    its(:url) { is_expected.to include 'rfr_id=info:sid/primo.exlibrisgroup.com:primo-nyu_aleph00098020' }

    context 'when record has special characters' do
      before do
        @record_with_special_chars = Record.new(external_system: 'primo', external_id: 'nyu_aleph006908640').becomes_external_system
        @record_with_special_chars.save
      end
      subject { @record_with_special_chars }
      its(:author) { is_expected.to eql 'Pedró, Francesc; Programme for International Student Assessment; Centre for Educational Research and Innovation; Organisation for Economic Co-operation and Development' }
    end

    describe '#locations' do
      subject { @record.locations }
      its(:size) { is_expected.to eql 2 }
      its(:'first.collection') { is_expected.to eql 'NYU Bobst Main Collection' }
      its(:'first.call_number') { is_expected.to eql '(HN49.I56 M67 2003 )' }
      its(:'last.collection') { is_expected.to eql 'New School Offsite Storage Main Collection' }
      its(:'last.call_number') { is_expected.to eql '(HN49.I56 M67 2003 )' }
    end
  end

end