Given %r{^I fill in the following under "([^"]*)":$} do |fieldset, table|
  within_fieldset(fieldset) do
    step 'I fill in the following:', table
  end
end

Given %r{^I fill in "([^"]*)" with "([^"]*)" under "([^"]*)"$} do |field, value, fieldset|
  within_fieldset(fieldset) do
    step %|I fill in "#{field}" with "#{value}"|
  end
end

Given %r{^I am already signed in as "([^"]*)"$} do |someone|
  user = FactoryGirl.build(someone)
  step "#{someone} exists" rescue nil
  step %|I go to sign in page|
  step %|I fill in "Login" with "#{user.login}"|
  step %|I fill in "Password" with "#{user.password}"|
  step %|I press "Sign in"|
end

Then %r{^I should see (success|error) message "([^"]*)"$} do |type, message|
  type = 'notice' if type == 'success'
  within("#flash .message.#{type}") do
    if page.respond_to? :should
      page.should have_content(message)
    else
      assert page.has_content?(message)
    end
  end
end

Given %r{^I follow "([^"]*)" \/ "([^"]*)"$} do |link1, link2|
  [link1, link2].each{|link| step %|I follow "#{link}"| }
end

Then %r{^I should see error fields?:? (.*)$} do |fields|
  while match = fields.match(/((.*?)"([^"]+)")/)
    xpath = '//li[contains(concat(" ",@class," ")," error ")]/label[text()="%s"]' % match[3]
    fields.sub!(match[1],'')
    if page.respond_to? :should
      page.should have_xpath(xpath)
    else
      assert page.has_xpath?(xpath)
    end
  end
end

Then %r{^I should see "([^"]*)" with error "([^"]*)"$} do |field, message|
  xpath = [
    '//li[contains(concat(" ",@class," "),"error")]',
    'label[text()="%s"]' % field,
    'following-sibling::*[text()="%s"]' % message
  ].join('/')
  if page.respond_to? :should
    page.should have_xpath(xpath)
  else
    assert page.has_xpath?(xpath)
  end
end

Then %r{^I should see "([^"]*)" page$} do |title|
  step 'I should see "%s" within "h2"' % title
end

Then %r{^I should see "([^"]*)" in (\w+) search result$} do |title, model|
  step %|I should see "#{title}" within ".#{model} .title"|
end

Then %r{^I should see empty (\w+) search result$} do |model|
  selector = ".#{model} .title"
  if page.respond_to? :should
    page.should have_no_css(selector)
  else
    assert page.has_no_css?(selector)
  end
end

Then %r{^I should not be able to press "([^"]*)"$} do |button|
  lambda{ step %|I press "#{button}"| }.should raise_error(Capybara::ElementNotFound)
end
