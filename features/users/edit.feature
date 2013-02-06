Feature: Edit user

  Scenario: Update Profile
    Given I am already signed in as "flyerhzm"
    When I follow "flyerhzm"
    And I follow "Edit"
    Then I should be on the user edit page
    When I fill in the following:
       | Login        | new_user            |
       | Email        | new_user@gmail.com  |
       | Your Website | http://new_user.com |
    And I press "Save" within "form.user:first"
    Then I should see "Account updated."
    And a user should exist with login: "new_user", url: "http://new_user.com"
