require 'rails_helper'

describe FiltersHelper do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in create(:user)
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
    subject { helper.send(:cite_path, format) }
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

  describe '#sort_options' do
    subject { helper.sort_options }
    its(:size) { is_expected.to eql 3 }

    context 'when the default sort option is selected' do
      before { controller.params = controller.params.merge(sort: nil) }
      its([0]) { is_expected.to include %Q(<a class="sorted asc" href="/records?sort=created_at_desc">date added</a>) }
      its([1]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=title_sort_asc">title</a>) }
      its([2]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=author_asc">author</a>) }
    end
    context 'when date added sort option is selected' do
      before { controller.params = controller.params.merge(sort: "created_at_asc") }
      its([0]) { is_expected.to include %Q(<a class="sorted asc" href="/records?sort=created_at_desc">date added</a>) }
      its([1]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=title_sort_asc">title</a>) }
      its([2]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=author_asc">author</a>) }
    end
    context 'when title sort option is selected' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc") }
      its([0]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=created_at_asc">date added</a>) }
      its([1]) { is_expected.to include %Q(<a class="sorted asc" href="/records?sort=title_sort_desc">title</a>) }
      its([2]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=author_asc">author</a>) }
      context 'and then title sort is selected again to reverse order' do
        before { controller.params = controller.params.merge(sort: "title_sort_desc") }
        its([0]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=created_at_asc">date added</a>) }
        its([1]) { is_expected.to include %Q(<a class="sorted desc" href="/records?sort=title_sort_asc">title</a>) }
        its([2]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=author_asc">author</a>) }
      end
    end
    context 'when author option is selected' do
      before { controller.params = controller.params.merge(sort: "author_asc") }
      its([0]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=created_at_asc">date added</a>) }
      its([1]) { is_expected.to include %Q(<a class="sorted" href="/records?sort=title_sort_asc">title</a>) }
      its([2]) { is_expected.to include %Q(<a class="sorted asc" href="/records?sort=author_desc">author</a>) }
    end

  end

	describe '#current_sort_label' do
		subject { helper.current_sort_label }

		context 'when no sort is selected' do
      it { is_expected.to eql 'date added' }
		end
		context 'when title_sort is the selected sort' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc") }
      it { is_expected.to eql 'title' }
		end
		context 'when a random value is the selected sort' do
      before { controller.params = controller.params.merge(sort: ";insert malicious_code into user_table") }
      it { is_expected.to eql 'date added' }
		end
	end

  describe '#parsed_current_sort' do
    subject { helper.parsed_current_sort }

    context 'when no sort option is selected' do
      it { is_expected.to eql ["created_at", "asc"] }
    end
    context 'when title_sort is the selected sort option' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc") }
      it { is_expected.to eql ["title_sort", "asc"] }
    end
    context 'when arbitrary text is the selected sort option' do
      before { controller.params = controller.params.merge(sort: "blah_blah_blah_desc") }
      it { is_expected.to eql ["created_at", "asc"] }
    end
  end
  
  describe '#secondary_sort' do
    subject { helper.secondary_sort }
    context 'when primary sort id title_sort' do
      before { controller.params = controller.params.merge(sort: "title_sort_asc") }
      it { is_expected.to eql :created_at }
    end
    context 'when primary sort id author' do
      before { controller.params = controller.params.merge(sort: "author_desc") }
      it { is_expected.to eql :title_sort }
    end
    context 'when primary sort id created_at' do
      before { controller.params = controller.params.merge(sort: "created_at_asc") }
      it { is_expected.to eql :created_at }
    end
  end

  describe '#sort_param' do
    subject { helper.send(:sort_param, sort_field) }

    context 'when sort_field is the current sort field' do
      context 'and the sort direction is ASC' do
        before { controller.params = controller.params.merge(sort: "created_at_asc") }
        let(:sort_field) { "created_at" }
        it { is_expected.to eql "created_at_desc" }
      end
      context 'and the sort direction is DESC' do
        before { controller.params = controller.params.merge(sort: "created_at_desc") }
        let(:sort_field) { "created_at" }
        it { is_expected.to eql "created_at_asc" }
      end
    end
    context 'when sort_field is not the current sort field' do
      context 'and the sort direction is ASC' do
        before { controller.params = controller.params.merge(sort: "created_at_asc") }
        let(:sort_field) { "title_sort" }
        it { is_expected.to eql "title_sort_asc" }
      end
    end
  end
  
  describe '#sort_direction_class' do
    subject { helper.send(:sort_direction_class, sort_field) }

    context 'when sort_field is the current sort field' do
      context 'and the sort direction is ASC' do
        before { controller.params = controller.params.merge(sort: "created_at_asc") }
        let(:sort_field) { "created_at" }
        it { is_expected.to eql " asc" }
      end
      context 'and the sort direction is DESC' do
        before { controller.params = controller.params.merge(sort: "created_at_desc") }
        let(:sort_field) { "created_at" }
        it { is_expected.to eql " desc" }
      end
    end
    context 'when sort_field is not the current sort field' do
      before { controller.params = controller.params.merge(sort: "created_at_desc") }
      let(:sort_field) { "title_sort" }
      it { is_expected.to be_nil }
    end
	end

  describe '#switch_sort_direction' do
    subject { helper.send(:switch_sort_direction, direction) }

    context 'when direction is ASC' do
      let(:direction) { 'asc' }
      it { is_expected.to eql 'desc' }
    end
    context 'when direction is DESC' do
      let(:direction) { 'desc' }
      it { is_expected.to eql 'asc' }
    end
  end
  
  describe '#whitelisted_sort_field?' do
    subject { helper.send(:whitelisted_sort_field?, sort_field) }

    context 'when sort_field is created_at' do
      let(:sort_field) { "created_at_asc" }
      it { is_expected.to be true }
    end
    context 'when sort_field is title_sort' do
      let(:sort_field) { "title_sort_desc" }
      it { is_expected.to be true }
    end
    context 'when sort_field is author' do
      let(:sort_field) { "author_desc" }
      it { is_expected.to be true }
    end
    context 'when sort_field is anything else' do
      let(:sort_field) { "title_desc_asc" }
      it { is_expected.to be false }
    end
	end

	
end