RSpec.describe "GET /account", :type => :request do
  it "redirects to Primo My Library Account" do
    get "/account"
    expect(response).to redirect_to(URI.escape("#{ENV['PRIMO_BASE_URL']}/primo-explore/account?vid=NYU&section=overview"))
  end
end
