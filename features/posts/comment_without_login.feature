Feature: Comment Post without Login

  Background:
    Given a user "richard" exists with login: "richard"
    And a post exists with user: user "richard", title: "first best practice"
    And I go to the home page
    And I follow "first best practice"

  Scenario: Successful comment with valid info
    Given I fill in the following under "Post a comment":
      | Username | flyerhzm  |
      | Content  | good post |
    When I press "Comment" at "July 24, 2010 13:52"
    Then I should see "Comment was successfully created"
    And I should see the following new entry under "Comments":
    """
      Posted by flyerhzm on July 24, 2010 13:52
      > good post
    """

  Scenario Outline: Unsuccessful comment with invalid info
    Given I fill in the following under "Post a comment":
      | Username | <username> |
      | Content  | <content>  |
    When I press "Comment"
    Then I should be on comment post failure page
    And I should see "<field>" with error "can't be blank"

    Examples:
      | username  | content   | field    |
      |           | good post | Username |
      | flyerhzm  |           | Content  |

