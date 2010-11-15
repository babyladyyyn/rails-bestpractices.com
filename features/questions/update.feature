Feature: Update Question

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a question exists with user: user "flyerhzm", title: "first question"
    And I am already signed in as "flyerhzm"
    And I follow "Questions" / "first question"
    And I follow "Edit"

  Scenario: Successful edit with valid info
    Given I fill in the following:
      | Title              | edit question                 |
      | Tag list           | edit, test                    |
      | Content            | *edit-italic* **bold**        |
    When I press "Save"
    Then I should see success message "Question was successfully updated."
    And I should see "edit question" page
    And I should see "edit" within ".tags a"
    And I should see "test" within ".tags a"
    And I should see "edit-italic" within ".wikistyle em"
    And I should see "bold" within ".wikistyle strong"

  Scenario Outline: Unsuccessful edit with missing info
    Given I fill in the following:
      | Title              | <title>   |
      | Content            | <content> |
      | Tag list           |           |
    When I press "Save"
    Then I should be on update question failure page
    And I should see "<field>" with error "can't be blank"

    Examples:
      | title     | content   | field   |
      |           | something | Title   |
      | something |           | Content |

  Scenario: Unsuccessful edit with duplicated title
    Given a question exists with title: "edit question"
    And I fill in the following:
      | Title              | edit question           |
      | Tag list           | edit, test              |
      | Content            | *edit-italic* **bold**  |
    When I press "Save"
    Then I should see "Title" with error "has already been taken"

