Around('@omniauth_test') do |scenario, block|
  OmniAuth.config.test_mode = true
  block.call
  OmniAuth.config.test_mode = false
end

Given(/^I am logged in$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = omniauth_hash
  ignore_passive_login("/login")
  @ignored = true
  visit '/login'
end

Given(/^I am not logged in$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = nil
end

Given(/^I am logged in as a non aleph user$/) do
  OmniAuth.config.mock_auth[:nyulibraries] = non_aleph_omniauth_hash
  ignore_passive_login("/login")
  @ignored = true
  visit '/login'
end
