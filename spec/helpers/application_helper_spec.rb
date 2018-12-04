require 'rails_helper'

describe ApplicationHelper do

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in create(:user)
  end

  describe "#ill" do
    subject { helper.ill_url }
    context 'institution is NYU' do
      it { is_expected.to eql "https://dev.ill.library.nyu.edu" }
    end
    context 'institution is NYUAD' do
      before { allow(helper).to receive(:current_primary_institution).and_return Institutions.institutions[:NYUAD] }
      it { is_expected.to eql "https://dev.ill.library.nyu.edu" }
    end
    context 'institution is NYUSH' do
      before { allow(helper).to receive(:current_primary_institution).and_return Institutions.institutions[:NYUSH] }
      it { is_expected.to eql "https://dev.ill.library.nyu.edu" }
    end
    context 'institution is NS' do
      before { allow(helper).to receive(:current_primary_institution).and_return Institutions.institutions[:NS] }
      it { is_expected.to eql "https://dev.ill.library.nyu.edu" }
    end
    context 'institution is CU' do
      before { allow(helper).to receive(:current_primary_institution).and_return Institutions.institutions[:CU] }
      it { is_expected.to be_nil }
    end
    context 'institution is HSL' do
      before { allow(helper).to receive(:current_primary_institution).and_return Institutions.institutions[:HSL] }
      it { is_expected.to be_nil }
    end
  end
end
