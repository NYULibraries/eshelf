require 'rails_helper'

describe ApplicationController do

  describe '#tmp_user' do
    let(:session) { {} }
    subject { controller.send(:tmp_user) }
    before { allow(controller).to receive(:session).and_return(session) }
    context 'when session is null' do
      it { is_expected.to be_instance_of TmpUser }
    end
    context 'when session is not null' do
      let(:session) {
        { tmp_user: create(:tmp_user) }
      }
      it { is_expected.to be_instance_of TmpUser }
    end
  end

end