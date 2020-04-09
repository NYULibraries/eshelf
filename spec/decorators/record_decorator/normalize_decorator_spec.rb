require 'rails_helper'

describe RecordDecorator::NormalizeDecorator, vcr: true do

  let(:record) { build(:user_primo_record1) }
  let(:normalized_record) { RecordDecorator::NormalizeDecorator.new(record) }

  describe '#title' do
    subject { normalized_record.title }
    it { is_expected.to eql 'Virtual inequality : beyond the digital divide (book)' }
  end

  describe '#url' do
    subject { normalized_record.url }
    it { is_expected.to start_with "https://getit.library.nyu.edu/resolve" }
  end

  describe '#author' do
    subject { normalized_record.author }
    it { is_expected.to include 'Mossberger, Karen' }
    context 'when record has a creator only' do
      let(:record) { build(:primo_record_with_creator) }
      it { is_expected.to eql 'Monroe, Barbara Jean, 1948-' }
    end
    context 'when record does not have an author' do
      let(:record) { build(:primo_record_without_author) }
      it { is_expected.to be_nil }
    end
  end

  describe '#publisher' do
    subject { normalized_record.publisher }
    it { is_expected.to eql 'Georgetown University Press' }
  end

  describe '#city_of_publication' do
    subject { normalized_record.city_of_publication }
    it { is_expected.to eql 'Washington, D.C.' }
  end

  describe '#date_of_publication' do
    subject { normalized_record.date_of_publication }
    it { is_expected.to eql '2003' }
  end

  describe '#journal_title' do
    subject { normalized_record.journal_title }
    it { is_expected.to be_nil }
  end

  describe '#subjects' do
    subject { normalized_record.subjects }
    it { is_expected.to eql '' }
  end

  describe '#issn' do
    subject { normalized_record.issn }
    it { is_expected.to be_nil }
  end

  describe '#eissn' do
    subject { normalized_record.eissn }
    it { is_expected.to be_nil }
  end

  describe '#isbn' do
    subject { normalized_record.isbn }
    it { is_expected.to eql '0878409998; 9780878409990' }
  end

  describe '#related_titles' do
    subject { normalized_record.related_titles }
    it { is_expected.to be_nil }
  end

  describe '#language' do
    subject { normalized_record.language }
    it { is_expected.to eql 'eng' }
  end

  describe '#description' do
    subject { normalized_record.description }
    it { is_expected.to be_nil }
  end

  describe '#notes' do
    subject { normalized_record.notes }
    it { is_expected.to eql 'Includes bibliographical references (p. [171]-183) and index.' }
  end

end