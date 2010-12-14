Feature: Share Post

  Background:
    Given I am already signed in as "flyerhzm"
    And I follow "Share"

  Scenario: Accessing create post page
    Then I should see "Share a Rails Best Practice" page

  Scenario: Successful create with valid info
    Given I fill in the following:
      | Title              | first best practice            |
      | Short Description  | first short description        |
      | Content            | *italic* **bold**              |
      | Tag list           | rails, test                    |
    When I press "Share"
    Then I should be on the posts page
     And I should see success message "Your Best Practice has been submitted and is pending approval."

  Scenario Outline: Unsuccessful create with missing info
    Given I fill in the following:
      | Title              | <title>   |
      | Short Description  |           |
      | Content            | <content> |
      | Tag list           |           |
    When I press "Share"
    Then I should be on create post failure page
    And I should see "<field>" with error "can't be blank"

    Examples:
      | title     | content   | field   |
      |           | something | Title   |
      | something |           | Content |

  Scenario: Unsuccessful create with duplicated title
    Given a post exists with title: "first best practice"
    And I fill in the following:
      | Title              | first best practice     |
      | Short Description  | first short description |
      | Content            | *italic* **bold**       |
      | Tag list           | rails, test             |
    When I press "Share"
    Then I should be on create post failure page
    And I should see "Title" with error "has already been taken"

