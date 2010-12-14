Feature: Show Posts and Questions with Tag

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And the following posts exist
      | user            | title         | tag_list | published |
      | user "flyerhzm" | "first post"  | "test"   | true      |
      | user "flyerhzm" | "second post" | "none"   | true      |
      | user "flyerhzm" | "third post"  | "test"   | true      |
      | user "flyerhzm" | "fourth post" | "test"   | false     |
    And the following questions exist
      | user            | title             | tag_list |
      | user "flyerhzm" | "first question"  | "test"   |
      | user "flyerhzm" | "second question" | "none"   |
      | user "flyerhzm" | "third question"  | "test"   |
    And I go to the home page

  Scenario: Show posts with tag
    When I follow "test"
    Then I should see "first post"
    And I should see "third post"
    And I should not see "second post"
    And I should not see "fourth post"

  Scenario: Show questions with tag
    When I follow "test"
    And I follow "Questions" within ".navs"
    Then I should see "first question"
    And I should see "third question"
    And I should not see "second question"
