Given %r{^I fill in the following under "([^"]*)":$} do |fieldset, table|
  within_fieldset(fieldset) do
    Given 'I fill in the following:', table
  end
end

Given %r{^I fill in "([^"]*)" with "([^"]*)" under "([^"]*)"$} do |field, value, fieldset|
  within_fieldset(fieldset) do
    Given %|I fill in "#{field}" with "#{value}"|
  end
end

Given %r{^I am already signed in as "([^"]*)"$} do |someone|
  user = Factory.build(someone)
  Given "#{someone} exists" rescue nil
  And %|I go to sign in page|
  And %|I fill in "Login" with "#{user.login}"|
  And %|I fill in "Password" with "#{user.password}"|
  And %|I press "Sign in"|
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
  [link1, link2].each{|link| Given %|I follow "#{link}"| }
end

When %r{I press "([^"]*)" at "([^"]*)"$} do |button, timing|
  Time.xstub(:now => Time.zone.parse(timing))
  When %|I press "#{button}"|
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
  Then 'I should see "%s" within "h2"' % title
end

Then %r{^I should see "([^"]*)" in (\w+) search result$} do |title, model|
  Then %|I should see "#{title}" within ".#{model} .title"|
end

Then %r{^I should see empty (\w+) search result$} do |model|
  selector = ".#{model} .title"
  if page.respond_to? :should
    page.should have_no_css(selector)
  else
    assert page.has_no_css?(selector)
  end
end

Then %r{^I should see the following new entry under "([^"]*)":$} do |title, string|
  info, content = string.split("\n").map(&:strip).
    inject([[],[]]) do |memo, line|
      if _line = line[/^> (.*)/, 1]
        memo[1] << _line
      else
        memo[0] << line
      end
      memo
    end.map{|s| s.join(' ') }
  xpath = [
    %|//*[h3="#{title}"]|,
    %|*[contains(concat(" ",@class," "),"#{title.tableize.singularize}")]|,
    %|*[contains(concat(" ",@class," "),"info")][normalize-space(.)="#{info}"]|,
    %|following-sibling::*[contains(concat(" ",@class," "),"content")][normalize-space(.)="#{content}"]|
  ].join('/')
  if page.respond_to? :should
    page.should have_xpath(xpath)
  else
    assert page.has_xpath?(xpath)
  end
end

Then %r{^I should not be able to press "([^"]*)"$} do |button|
  lambda{ When %|I press "#{button}"| }.should raise_error(Capybara::ElementNotFound)
end
