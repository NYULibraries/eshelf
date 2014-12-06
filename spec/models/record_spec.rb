require 'rails_helper'

describe Record do
  let(:user) { create(:user) }
  let(:tmp_user) { create(:tmp_user) }
  let(:external_system) { 'external_system' }
  let(:external_id) { 'external_id' }
  let(:format) { 'format' }
  let(:data) { 'data' }
  let(:title) { 'title' }
  let(:author) { 'author' }
  let(:url) { 'http://example.com' }
  let(:title_sort) { 'title' }
  let(:content_type) { 'content_type' }

  subject(:record) {
    Record.new(
      external_system: external_system,
      external_id: external_id,
      format: format,
      data: data,
      title: title,
      author: author,
      url: url,
      title_sort: title_sort,
    )
  }

  context 'when initialized with all required fields' do

    it { is_expected.to be_a(Record) }
    it { is_expected.to be_a_new(Record) }
    it { is_expected.to be_taggable }

    context 'but without a user or a temporary user' do
      it { is_expected.not_to be_valid }
    end

    context 'and with a user' do
      before { record.user = user }
      it { is_expected.to be_valid }

      context 'and saved' do
        before { record.save }
        it { is_expected.to be_persisted }
      end
    end

    context 'and with a temporary user' do
      before { record.tmp_user = tmp_user }
      it { is_expected.to be_valid }

      context 'and saved' do
        before { record.save }
        it { is_expected.to be_persisted }
      end
    end
  end

  context 'when initialized without an external system' do
    let(:external_system) { nil }

    context 'and with a user' do
      before { record.user = user }
      it { is_expected.to be_valid }
      it 'should get the external system from the class name upon validation' do
        expect(record.external_system).to eq external_system
        record.valid?
        expect(record.external_system).to eq 'record'
      end
    end

    context 'and with a temporary user' do
      before { record.tmp_user = tmp_user }
      it { is_expected.to be_valid }
      it 'should get the external system from the class name upon validation' do
        expect(record.external_system).to eq external_system
        record.valid?
        expect(record.external_system).to eq 'record'
      end
    end
  end

  context 'when initialized without an external id' do
    let(:external_id) { nil }

    context 'and with a user' do
      before { record.user = user }
      it { is_expected.not_to be_valid }
    end

    context 'and with a temporary user' do
      before { record.tmp_user = tmp_user }
      it { is_expected.not_to be_valid }
    end
  end

  context 'when initialized without a title' do
    let(:title) { nil }

    context 'and with a user' do
      before { record.user = user }
      it { is_expected.not_to be_valid }
    end

    context 'and with a temporary user' do
      before { record.tmp_user = tmp_user }
      it { is_expected.not_to be_valid }
    end
  end
end
