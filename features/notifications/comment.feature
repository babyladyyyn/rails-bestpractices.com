Feature: Comment Notification

  Scenario: Send notification to post user
    Given a user "richard" exists with login: "richard"
    And a post exists with user: user "richard", title: "first best practice"
    And I am already signed in as "flyerhzm"
    And I follow "first best practice"

    Given I fill in "Content" with "good post" under "Post a comment"
    When I press "Comment"
    And all delayed jobs have finished
    Then "richard@gmail.com" should receive an email

  Scenario: Send notification to post user and comment users
    Given a user "richard" exists with login: "richard"
    And a user "comment1" exists with login: "comment1"
    And a user "comment2" exists with login: "comment2"
    And a post "first" exists with user: user "richard", title: "first best practice"
    And a comment exists with commentable: post "first", user: user "comment1"
    And a comment exists with commentable: post "first", user: user "comment2"
    And I login as user "comment1" with password: "comment1"
    And I follow "first best practice"

    Given I fill in "Content" with "good post" under "Post a comment"
    When I press "Comment"
    And all delayed jobs have finished
    Then "richard@gmail.com" should receive an email
    And "comment1@gmail.com" should receive no email
    And "comment2@gmail.com" should receive an email
