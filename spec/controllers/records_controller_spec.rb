require 'rails_helper'

describe RecordsController do

  let(:whitelisted_origins) do
    ['https://ezproxy.library.edu','ezproxy.library.edu',]
  end

  describe '#origin_is_whitelisted?' do
    before { allow_any_instance_of(RecordsController).to receive(:whitelisted_origins).and_return(whitelisted_origins) }
    subject { @controller.send(:origin_is_whitelisted?) }
    context 'when HTTP_ORIGIN is whitelisted' do
      context 'and HTTP_ORIGIN is an exact match' do
        before { @request.env['HTTP_ORIGIN'] = 'ezproxy.library.edu' }
      end
      context 'and HTTP_ORIGIN includes non-specified port numbers' do
        before { @request.env['HTTP_ORIGIN'] = 'https://ezproxy.library.edu:8982' }
        it { is_expected.to be true }
      end
    end
    context 'when HTTP_ORIGIN is not whitelisted' do
      before { @request.env['HTTP_ORIGIN'] = 'https://ezproxy.library.edu/https://evilproxy.library.edu/' }
      it { is_expected.to be false }
    end
  end

end
