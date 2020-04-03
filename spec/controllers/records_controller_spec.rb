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

  describe 'GET /records/1/getit' do
    let!(:user)    { FactoryBot.create(:user) }
    before(:each) { allow_any_instance_of(RecordsController).to receive(:current_user).and_return(user) }
    before(:each) { allow_any_instance_of(Eshelf::Citation).to receive(:openurl).and_return(primo_record.url) }
    let!(:primo_record)  { FactoryBot.build(:user_primo_record1) }
    subject { get :getit, params: {id: record.id} }
    context 'when the user is an NYU user' do
      context 'and the record is a primo record' do
        let(:record) { primo_record }
        it { is_expected.to redirect_to "#{ENV['PERSISTENT_LINKER_URL']}#{record.external_id}?institution=NYU" }
        it 'should not have a X-CSRF-Token header' do
          expect(response.headers['X-CSRF-Token']).to be_nil
        end
      end
    end
    context 'when the user is not an NYU user' do
      let!(:user) { FactoryBot.create(:nysid_user) }
      context 'and the record is a primo record' do
        let(:record) { primo_record }
        it { is_expected.to redirect_to "#{ENV['PERSISTENT_LINKER_URL']}#{record.external_id}?institution=NYSID" }
        it 'should not have a X-CSRF-Token header' do
          expect(response.headers['X-CSRF-Token']).to be_nil
        end
      end
    end
  end

  describe 'GET /records/1' do
    let!(:user_record) { create(:user_record, data: "data") }
    let!(:user) { user_record.user }
    let!(:record_id) { user_record.id }
    let!(:tmp_user_record) { create(:tmp_user_record, data: "data") }
    let!(:tmp_user) { tmp_user_record.tmp_user }
    let!(:tmp_record_id) { tmp_user_record.id }

    context 'when user is not a temporary user' do
      before do
        allow_any_instance_of(RecordsController).to receive(:current_user).and_return(user)
      end
      
      before { get :show, params: { format: format, id: record_id } }
      subject { response }

      context 'when format is XML' do
        let(:format) { "xml" }
        its(:status) { is_expected.to eql 200 }
        its(:headers) { is_expected.to_not include 'X-CSRF-Token' }
        its(:content_type) { is_expected.to include 'application/xml' }
      end
      context 'when format is JSON' do
        let(:format) { "json" }
        its(:status) { is_expected.to eql 200 }
        its(:content_type) { is_expected.to include 'application/json' }
        its(:headers) { is_expected.to_not include 'X-CSRF-Token' }
      end
    end
    context 'when user is a temporary user' do
      before do
        allow_any_instance_of(RecordsController).to receive(:user).and_return(tmp_user)
      end

      before { get :show, params: { format: format, id: tmp_record_id } }
      subject { response }

      context 'when format is XML' do
        let(:format) { "xml" }
        its(:status) { is_expected.to eql 200 }
        its(:headers) { is_expected.to_not include 'X-CSRF-Token' }
        its(:content_type) { is_expected.to include 'application/xml' }
      end
      context 'when format is JSON' do
        let(:format) { "json" }
        its(:status) { is_expected.to eql 200 }
        its(:content_type) { is_expected.to include 'application/json' }
        its(:headers) { is_expected.to_not include 'X-CSRF-Token' }
      end

    end
  end

end
