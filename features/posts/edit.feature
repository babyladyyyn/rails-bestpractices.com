Feature: Edit Post

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a post exists with user: user "flyerhzm", title: "first best practice"
    And I am already signed in as "flyerhzm"
    And I follow "first best practice" / "Edit"

  Scenario: Successful edit with valid info
    Given I fill in the following:
      | Title              | edit best practices           |
      | Short Description  | edit short description        |
      | Tag list           | edit, test                    |
      | Content            | *edit-italic* **bold**        |
    When I press "Save"
    Then I should see success message "Best Practice was successfully updated!"
    And I should see "edit best practices" page
    # TODO: The following works, but too cryptic ... ideally, feature file shouldn't
    # deal with such low level stuff. Anyway, will leave it as it is for now,
    # till we can find a better way to express it.
    And I should see "edit short description" within ".description"
    And I should see "edit" within ".tags a"
    And I should see "test" within ".tags a"
    And I should see "edit-italic" within ".wikistyle em"
    And I should see "bold" within ".wikistyle strong"

  Scenario Outline: Unsuccessful edit with missing info
    Given I fill in the following:
      | Title              | <title>   |
      | Short Description  |           |
      | Content            | <content> |
      | Tag list           |           |
    When I press "Save"
    Then I should be on update post failure page
    And I should see "<field>" with error "can't be blank"

    Examples:
      | title     | content   | field   |
      |           | something | Title   |
      | something |           | Content |

  Scenario: Unsuccessful edit with duplicated title
    Given a post exists with title: "edit best practice"
    And I fill in the following:
      | Title              | edit best practice      |
      | Short Description  | edit short description  |
      | Tag list           | edit, test              |
      | Content            | *edit-italic* **bold**  |
    When I press "Save"
    Then I should see "Title" with error "has already been taken"

