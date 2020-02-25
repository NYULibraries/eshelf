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
    it { is_expected.to eql '' }
  # test "normalize author" do
  #   assert_equal "Karen.  Mossberger; Caroline J Tolbert; Mary Stansbury 1957-",
  #     @normalized_record.author, "Unexpected author"
  end


end