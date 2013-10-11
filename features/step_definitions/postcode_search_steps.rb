Given(/^you're on the home page$/) do
  visit root_url
end

When(/^you search for your postcode$/) do
  fill_in 'search_postcode', with: 'LS1'
  click_on 'Search'
end

Then(/^you're shown a list of nearby care homes$/) do
  expect(all('.result')).to have_at_least(1).item
end

When(/^you do not enter a postcode$/) do
  fill_in 'search_postcode', with: ''
  click_on 'Search'
end

Then(/^you're returned to the search form and informed of your error$/) do
  expect(page).to have_content 'You need to enter your postcode'
end

When(/^you enter an invalid postcode$/) do
  fill_in 'search_postcode', with: 'ERROR'
  click_on 'Search'
end

Then(/^you're returned to the search form and told there was a problem$/) do
  expect(page).to have_content 'Oops. Something went wrong. Please try again.'
end

Given(/^you're viewing the search results$/) do
  step "you're on the home page"
  step "you search for your postcode"
end

When(/^you click to view the map$/) do
  click_on 'Map'
end

Then(/^the results are displayed on a map$/) do
  expect(page).to have_selector '#map_canvas'
end
