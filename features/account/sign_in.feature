Feature: Account sign in

  Background:
    Given flyerhzm exists
    And I am on sign in page

  Scenario: Successful sign in with matching info
    Given I fill in the following:
      | Login | flyerhzm |
      | Password | flyerhzm |
    When I press "Sign in"
    Then I should be on the home page
    And I should see success message "Signed in successfully."
    And I should see "Sign out"

  Scenario Outline: Unsuccessful sign in with empty info
    Given I fill in the following:
       | Login    | <login>    |
       | Password | <password> |
    When I press "Sign in"
    Then I should be on sign in failure page
    And I should see "Invalid email or password."

    Examples:
      | username | password | field    |
      |          | 1234     | Login    |
      | flyerhzm |          | Password |

  Scenario Outline: Unsuccessful sign in with non-matching info
    Given I fill in the following:
      | Login    | <username> |
      | Password | <password> |
    When I press "Sign in"
    Then I should be on sign in failure page
    And I should see "Invalid email or password."

    Examples:
      | username | password | field    |
      | flyerhzm | 1234     | Password |
      | awesome  | flyerhzm | Login    |
