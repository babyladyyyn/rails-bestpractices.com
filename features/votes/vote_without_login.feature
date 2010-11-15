Feature: Vote Post without Login

  Background:
    Given a post exists with title: "first best practice", vote_points: 10
    And I am on the home page

  Scenario: Unsuccessful vote for "Like"
    Given I follow "first best practice"
    Then I should not be able to press "Like"

  Scenario: Unsuccessful vote for "Dislike"
    Given I follow "first best practice"
    Then I should not be able to press "Dislike"

