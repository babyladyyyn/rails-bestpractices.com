Feature: List comments

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a post "first" exists with user: user "flyerhzm", title: "first post", published: true
    And a post "second" exists with user: user "flyerhzm", title: "scond post", published: true
    And the following comments exist
      | user            | username   | email                | body             |
      | user "flyerhzm" |            |                      | "first comment"  |
      |                 | "anonymous | "annoymous@test.com" | "second comment" |

  Scenario: list comments
    When I go to the home page
    And I follow "Recent Comments"
    Then I should see "first comment"
    Then I should see "second comment"
