When(/^I login as #{capture_model} with password[:] "([^"]*)"$/) do |name, password|
  user = model name
  visit new_user_session_path
  fill_in "Login", :with => user.login
  fill_in "Password", :with => password
  click_button "Sign in"
end

