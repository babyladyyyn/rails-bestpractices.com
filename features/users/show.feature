Feature: Show Posts and Questions with User

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a user "richard" exists with login: "richard"
    And the following posts exist
      | user            | title         | published |
      | user "flyerhzm" | "first post"  | true      |
      | user "richard"  | "second post" | true      |
      | user "flyerhzm" | "third post"  | true      |
      | user "flyerhzm" | "fourth post" | false     |
    And the following questions exist
      | user            | title             |
      | user "flyerhzm" | "first question"  |
      | user "richard"  | "second question" |
      | user "flyerhzm" | "third question"  |
    And I go to the home page

  Scenario: Show posts
    When I follow "flyerhzm"
    Then I should see "first post"
    And I should see "third post"
    And I should not see "second post"
    And I should not see "fourth post"

  Scenario: Show questions
    When I follow "flyerhzm"
    And I follow "Questions" within ".navs"
    Then I should see "first question"
    And I should see "third question"
    And I should not see "second question"

