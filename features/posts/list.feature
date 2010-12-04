Feature: List Posts

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And the following posts exist
      | user            | title         |
      | user "flyerhzm" | "first post"  |
      | user "flyerhzm" | "second post" |
      | user "flyerhzm" | "third post"  |

  Scenario: list posts
    When I go to the home page
    Then I should see "first post"
    And I should see "second post"
    And I should see "third post"
