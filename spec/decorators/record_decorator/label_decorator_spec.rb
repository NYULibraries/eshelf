require 'rails_helper'

describe RecordDecorator::LabelDecorator, vcr: true do

  let(:record) { build(:user_primo_record1) }
  let(:normalized_record) { RecordDecorator::NormalizeDecorator.new(record) }
  let(:labeled_record) { RecordDecorator::LabelDecorator.new(normalized_record) }

  describe '#url' do
    subject { labeled_record.url }
    it { is_expected.to start_with 'https://getit.library.nyu.edu/resolve' }
  end

  describe '#locations_label' do
    subject { labeled_record.locations_label }
    it { is_expected.to eql 'Locations:' }
  end

  describe '#author' do
    subject { labeled_record.author }
    it { is_expected.to start_with 'Author:' }
  end

  describe '#publisher' do
    subject { labeled_record.publisher }
    it { is_expected.to start_with 'Publisher:' }
  end

  describe '#city_of_publication' do
    subject { labeled_record.city_of_publication }
    it { is_expected.to start_with 'City of Publication:' }
  end

  describe '#date_of_publication' do
    subject { labeled_record.date_of_publication }
    it { is_expected.to start_with 'Date of Publication:' }
  end

  describe '#journal_title' do
    subject { labeled_record.journal_title }
    it { is_expected.to be_nil }
  end

  describe '#subjects' do
    subject { labeled_record.subjects }
    it { is_expected.to be_nil }
  end

  describe '#issn' do
    subject { labeled_record.issn }
    it { is_expected.to be_nil }
  end

  describe '#eissn' do
    subject { labeled_record.eissn }
    it { is_expected.to be_nil }
  end

  describe '#isbn' do
    subject { labeled_record.isbn }
    it { is_expected.to start_with "ISBN:" }
  end

  describe '#related_titles' do
    subject { labeled_record.related_titles }
    it { is_expected.to be_nil }
  end

  describe '#language' do
    subject { labeled_record.language }
    it { is_expected.to start_with "Language:" }
  end

  describe '#description' do
    subject { labeled_record.description }
    it { is_expected.to be_nil }
  end

  describe '#notes' do
    subject { labeled_record.notes }
    it { is_expected.to start_with "Notes:" }
  end

end