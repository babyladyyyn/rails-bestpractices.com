Feature: List Blog Posts

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And the following blog posts exist
      | user            | title              |
      | user "flyerhzm" | "first blog post"  |
      | user "flyerhzm" | "second blog post" |

  Scenario: list blog posts
    When I go to the home page
    And show me the page
    And I follow "Blog" within "#header"
    Then I should see "first blog post"
    And I should see "second blog post"
