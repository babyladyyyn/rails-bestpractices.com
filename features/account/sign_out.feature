Feature: Account sign out

  Background:
    Given I am already signed in as "flyerhzm"

  Scenario: Successful sign out
    When I follow "Sign out"
    Then I should see "Signed out successfully."
    And I should see "Sign in"
