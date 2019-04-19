require 'rails_helper'

describe RecordsController do

  let(:whitelisted_origins) do
    ['https://ezproxy.library.edu','ezproxy.library.edu',/^http(s)?:\/\/ezproxy\.library\.edu:(\d+)$/]
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
      before { @request.env['HTTP_ORIGIN'] = 'https://evilproxy.library.edu/https://ezproxy.library.edu' }
      it { is_expected.to be false }
    end
  end

  describe '#getit' do
    before(:each) { allow_any_instance_of(RecordsController).to receive(:current_user).and_return(user) }
    before(:each) { allow_any_instance_of(Eshelf::PnxJson).to receive(:openurl).and_return(record.url) }
    let!(:record)  { FactoryBot.create(:user_record, :primo, data: "data") }
    subject { get :getit, params: { id: record.id } }
    context 'when the user is an NYU user' do
      let!(:user)    { FactoryBot.create(:user) }
      it 'should redirect to a getit', :vcr do
        expect(response).to redirect_to("https://dev.getit.library.nyu.edu/nyu/resolve?#{record.url}")
        expect(response.headers['X-CSRF-Token']).to be_nil
      end
    end
    context 'when the user is not an NYU user' do
      let!(:user)    { FactoryBot.create(:nysid_user) }
      it 'should redirect to a configuration defined persistent linker' do
        expect(response).to redirect_to("#{ENV['PERSISTENT_LINKER_URL']}#{record.external_id}")
        expect(response.headers['X-CSRF-Token']).to be_nil
      end
    end
  end
end
