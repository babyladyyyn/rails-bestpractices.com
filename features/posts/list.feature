Feature: List Posts

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And the following posts exist
      | user            | title         | published |
      | user "flyerhzm" | "first post"  | true      |
      | user "flyerhzm" | "second post" | false     |
      | user "flyerhzm" | "third post"  | true      |

  Scenario: list posts
    When I go to the home page
    Then I should see "first post"
    And I should not see "second post"
    And I should see "third post"
