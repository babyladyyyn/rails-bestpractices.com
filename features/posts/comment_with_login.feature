Feature: Comment Post with Login

  Background:
    Given a user "richard" exists with login: "richard"
    And a post exists with user: user "richard", title: "first best practice"
    And I am already signed in as "flyerhzm"
    And I follow "first best practice"

  Scenario: Successful comment with valid info
    Given I fill in "Content" with "good post" under "Post a comment"
    When I press "Comment" at "July 24, 2010 13:52"
    Then I should see "Comment was successfully created"
    And I should see the following new entry under "Comments":
    """
      Posted by flyerhzm on July 24, 2010 13:52
      > good post
    """

  Scenario: Unsuccessful comment with empty content
    Given I fill in "Content" with "" under "Post a comment"
    When I press "Comment"
    Then I should be on comment post failure page
    And I should see "Content" with error "can't be blank"

