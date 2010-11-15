Feature: Vote Post with Login

  Background:
    Given a post exists with title: "first best practice", vote_points: 10
    Given I am already signed in as "flyerhzm"

  Scenario: Successfully voted "Like"
    Given I follow "first best practice"
    When I press "Like"
    Then I should see vote points as "11"
    And I should see vote icon as "Like"

  Scenario: Successfully voted "Dislike"
    Given I follow "first best practice"
    When I press "Dislike"
    Then I should see vote points as "9"
    And I should see vote icon as "Dislike"

  Scenario: Unsuccessful vote for "Like"
    Given I have previously voted "Like" for "first best practice"
    Then I should not be able to press "Like"

  Scenario: Unsuccessful vote for "Dislike"
    Given I have previously voted "Dislike" for "first best practice"
    Then I should not be able to press "Dislike"

