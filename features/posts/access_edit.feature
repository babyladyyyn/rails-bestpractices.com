Feature: Access Edit Post

  Background:
    Given users "flyerhzm" & "richard" exist
    And a post exists with user: user "flyerhzm", title: "awesome practice"

  Scenario: Non-owner cannot access edit post page
    Given I am already signed in as "richard"
    When I follow "awesome practice"
    Then I should see "awesome practice"
    But I should not see "Edit"

  Scenario: Owner can access edit post page
    Given I am already signed in as "flyerhzm"
    When I follow "awesome practice"
    Then I should see "awesome practice"
    When I follow "Edit"
    Then I should see "Edit a Rails Best Practice" page

