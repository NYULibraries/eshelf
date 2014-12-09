Given(/^I am on the e-Shelf$/) do
  visit root_path
end

Then(/^I should see a "(.*?)" link$/) do |text|
  expect(page).to have_css('a', text: text)
end
