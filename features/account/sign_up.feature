Feature: Account sign up

  Background:
    Given I am on the homepage
    And I follow "Sign up"

  Scenario: Successful sign up with valid info
    Given I fill in the following:
      | user_login                 | flyerhzm           |
      | user_email                 | flyerhzm@gmail.com |
      | user_password              | flyerhzm           |
      | user_password_confirmation | flyerhzm           |
    When I press "Sign up"
    Then I should be on the home page
    And I should see success message "You have signed up successfully."

  Scenario Outline: Unsuccessful sign up with duplicated info
    Given a user exists with <db-field>: "<value>"
    And I fill in the following:
      | user_login                 | flyerhzm           |
      | user_email                 | flyerhzm@gmail.com |
      | user_password              | flyerhzm           |
      | user_password_confirmation | flyerhzm           |
    When I press "Sign up"
    Then I should be on sign up failure page
    And I should see error field "<field>"

    Examples:
      | db-field | value              | field    |
      | login    | flyerhzm           | Login    |
      | email    | flyerhzm@gmail.com | Email    |

  Scenario: Unsuccessful sign up with invalid info
    # We only cover a subset of the invalid info, cos the validity of registration
    # (creating of new user) is actually handled by Authlogic.
    Given I fill in the following:
      | user_login                 | |
      | user_email                 | |
      | user_password              | |
      | user_password_confirmation | |
    When I press "Sign up"
    Then I should be on sign up failure page
    And I should see error fields: "Login", "Email" & "Password"
