Feature: Create Question

  Background:
    Given I am already signed in as "flyerhzm"
    And I follow "Questions" / "Question"

  Scenario: Accessing create post page
    Then I should see "Ask for Rails Best Practice" page

  Scenario: Successful create with valid info
    Given I fill in the following:
      | Title              | first question           |
      | Content            | *italic* **bold**        |
      | Tag list           | rails, test              |
    When I press "Post"
    Then I should see success message "Question was successfully created."
    And I should see "first question" page
    And I should see "rails" within ".tags a"
    And I should see "test" within ".tags a"
    And I should see "italic" within ".wikistyle em"
    And I should see "bold" within ".wikistyle strong"

  Scenario Outline: Unsuccessful create with missing info
    Given I fill in the following:
      | Title              | <title>   |
      | Content            | <content> |
      | Tag list           |           |
    When I press "Post"
    Then I should be on create question failure page
    And I should see "<field>" with error "can't be blank"

    Examples:
      | title     | content   | field   |
      |           | something | Title   |
      | something |           | Content |

  Scenario: Unsuccessful create with duplicated title
    Given a question exists with title: "first question"
    And I fill in the following:
      | Title              | first question     |
      | Content            | *italic* **bold**  |
      | Tag list           | rails, test        |
    When I press "Post"
    Then I should be on create question failure page
    And I should see "Title" with error "has already been taken"

