When(/^you click on the "Read more about..." link$/) do
  first('.read-more').click
end

Then(/^you are taken to the results view for that provider$/) do
  expect(page).to have_selector '.provider'
end
