Feature: Sign in with twitter

  Scenario: Successful sign in with twitter
    Given I am on the sign in page
    When I follow "Sign in with Twitter"
    Then I should be on sign up page
    And I should see error field "Email"
    When I fill in "Email" with "flyerhzm@gmail.com"
    And I press "Sign up"
    Then I should be on the homepage
    And I should see success message "You have signed up successfully."
