require 'rails_helper'

describe Location do
  let(:call_number) { '(HN49.I56 M67 2003)' }
  let(:collection) { 'NYU Bobst Main Collection' }
  let(:record) { create(:tmp_user_record, data: 'data') }

  subject(:location) {
    Location.new(
      record_id: record.id,
      call_number: call_number,
      collection: collection
    )
  }

  context 'when initialized with all fields' do

    it { is_expected.to be_a(Location) }
    it { is_expected.to be_a_new(Location) }
    it { is_expected.to be_valid }

    context 'and saved' do
      before { location.save }
      it { is_expected.to be_persisted }
    end

    context 'except a collection' do
      let(:collection) { nil }
      it { is_expected.to be_valid }
    end

    context 'except a call number' do
      let(:call_number) { nil }
      it { is_expected.to be_valid }
    end

    context 'except a collection and a call number' do
      let(:collection) { nil }
      let(:call_number) { nil }
      it { is_expected.not_to be_valid }
    end
  end

  describe '#to_s' do
    subject { location.to_s }
    it { is_expected.to eq "#{collection} #{call_number}" }
  end
end
