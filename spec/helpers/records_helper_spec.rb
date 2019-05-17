require 'rails_helper'

describe RecordsHelper do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in create(:user)
  end

  describe '#export_options' do
    subject { helper.export_options }
    it { is_expected.to be_a Array }
    its(:count) { is_expected.to eql 4 }
    its([0]) { is_expected.to include %Q(cite_to=refworks) }
    its([0]) { is_expected.to include %Q(Push to RefWorks) }
    its([1]) { is_expected.to include %Q(cite_to=endnote) }
    its([1]) { is_expected.to include %Q(Push to EndNote) }
    its([2]) { is_expected.to include %Q(cite_to=ris) }
    its([2]) { is_expected.to include %Q(Download as RIS) }
    its([3]) { is_expected.to include %Q(cite_to=bibtex) }
    its([3]) { is_expected.to include %Q(Download as BibTex) }
  end

  describe '#deselect_content_type' do
    subject { helper.deselect_content_type(content_type, current_content_type) }
    let(:content_type) { 'book' }
    let(:current_content_type) { 'article' }

    context 'when content type iteration does not match the currently selected content type' do
      it { is_expected.to be_nil }
    end

    context 'when content type iteration matches the currently selected content type' do
      let(:current_content_type) { 'book' }
      it { is_expected.to include '<span class="deselect_filter">' }
      it { is_expected.to include '/records"><i class="fa fa-times"></i></a>' }
    end
  end

  
end
