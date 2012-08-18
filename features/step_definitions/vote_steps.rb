Given %r{^I have previously voted "([^"]*)" for "([^"]*)"$} do |preference, post_title|
  step %|I follow "#{post_title}"|
  step %|I press "#{preference}"|
end

Then %r{^I should see vote points as "([^"]*)"$} do |points|
  step %|I should see "#{points}" within ".vote-info"|
end

Then %r{^I should see vote icon as "([^"]*)"$} do |preference|
  step %|I should see "#{preference}" within ".vote-info .#{preference.downcase}-icon"|
end
