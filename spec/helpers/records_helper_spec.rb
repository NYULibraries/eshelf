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

  describe '#per_page_options' do
    subject { helper.per_page_options }
    its(:size) { is_expected.to eql 4 }
    its([0]) { is_expected.to include %Q(<a href="/records?per=10">10</a>) }
    its([1]) { is_expected.to include %Q(<a href="/records?per=20">20</a>) }
    its([2]) { is_expected.to include %Q(<a href="/records?per=50">50</a>) }
    its([3]) { is_expected.to include %Q(<a href="/records?per=100">100</a>) }

    context 'when content_type is book' do
      before { controller.params = controller.params.merge(content_type: "book") }
      its([0]) { is_expected.to include %Q(<a href="/records?content_type=book&amp;per=10">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?content_type=book&amp;per=20">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?content_type=book&amp;per=50">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?content_type=book&amp;per=100">100</a>) }
    end
    context 'when id array is present' do
      before { controller.params = controller.params.merge(id: ["1", "2"]) }
      its([0]) { is_expected.to include %Q(<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=10">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=20">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=50">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?id%5B%5D=1&amp;id%5B%5D=2&amp;per=100">100</a>) }
    end
    context 'when id string is present' do
      before { controller.params = controller.params.merge(id: "1") }
      its([0]) { is_expected.to include %Q(<a href="/records?id=1&amp;per=10">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?id=1&amp;per=20">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?id=1&amp;per=50">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?id=1&amp;per=100">100</a>) }
    end
    context 'when tag is present' do
      before { controller.params = controller.params.merge(tag: "test tag") }
      its([0]) { is_expected.to include %Q(<a href="/records?per=10&amp;tag=test+tag">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?per=20&amp;tag=test+tag">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?per=50&amp;tag=test+tag">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?per=100&amp;tag=test+tag">100</a>) }
    end
    context 'when sort is present' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc") }
      its([0]) { is_expected.to include %Q(<a href="/records?per=10&amp;sort=title_sort_asc">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?per=20&amp;sort=title_sort_asc">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?per=50&amp;sort=title_sort_asc">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?per=100&amp;sort=title_sort_asc">100</a>) }
    end
    context 'when sort and tag are present' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc", tag: "test tag") }
      its([0]) { is_expected.to include %Q(<a href="/records?per=10&amp;sort=title_sort_asc&amp;tag=test+tag">10</a>) }
      its([1]) { is_expected.to include %Q(<a href="/records?per=20&amp;sort=title_sort_asc&amp;tag=test+tag">20</a>) }
      its([2]) { is_expected.to include %Q(<a href="/records?per=50&amp;sort=title_sort_asc&amp;tag=test+tag">50</a>) }
      its([3]) { is_expected.to include %Q(<a href="/records?per=100&amp;sort=title_sort_asc&amp;tag=test+tag">100</a>) }
    end
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

  describe '#sort_path' do
  end

  describe '#sort_options' do
  end

  describe '#current_sort_label' do
  end

  describe '#parsed_current_sort' do
  end

  describe '#sort_param' do
  end

  describe '#switch_sort_direction' do
  end

  describe '#sort_direction_class' do
  end

end
