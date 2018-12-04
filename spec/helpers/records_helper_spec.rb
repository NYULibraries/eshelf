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

  describe '#cite_path' do
    let(:format) { 'refworks' }
    subject { helper.cite_path(format) }
    context 'when format is refworks' do
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYU&cite_to=refworks' }
    end
    context 'when format is endnote' do
      let(:format) { 'endnote' }
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYU&cite_to=endnote' }
    end
    context 'when format is anything' do
      let(:format) { 'blah' }
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYU&cite_to=blah' }
    end
    context 'when institution is NYSID' do
      before { sign_in create(:nysid_user) }
      it { is_expected.to eql 'https://cite-dev.library.nyu.edu/?calling_system=primo&institution=NYSID&cite_to=refworks' }
    end
  end

end
