@no-txn
Feature: Search Post

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a post exists with user: user "flyerhzm", title: "first best practice"
    And I am already signed in as "flyerhzm"
    And the post indexes are processed

  Scenario: Successful search result
    Given I fill in "search" with "first best"
    When I press "Search"
    Then I should see "first best practice" in posts search result

  Scenario: Unsuccessful search result
    Given I fill in "search" with "1st best"
    When I press "Search"
    Then I should see empty posts search result
