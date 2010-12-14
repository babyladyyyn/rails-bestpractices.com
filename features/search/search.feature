@no-txn
Feature: Search Posts and Questions

  Background:
    Given a user "flyerhzm" exists with login: "flyerhzm"
    And a post exists with user: user "flyerhzm", title: "first best practice"
    And a post exists with user: user "flyerhzm", title: "unpublished best practice", published: false
    And a question exists with user: user "flyerhzm", title: "first question"
    And I go to the home page
    And the post indexes are processed
    And the question indexes are processed

  Scenario: Successful search result
    Given I fill in "search" with "first"
    When I press "Search"
    Then I should see "first best practice" in posts search result
    And I should see "first question" in questions search result

  Scenario: Successful posts search result
    Given I fill in "search" with "first best"
    When I press "Search"
    Then I should see "first best practice" in posts search result
    And I should see empty questions search result

  Scenario: Successful questions search result
    Given I fill in "search" with "first question"
    When I press "Search"
    Then I should see empty posts search result
    And I should see "first question" in questions search result

  Scenario: Unsuccessful search result
    Given I fill in "search" with "1st best"
    When I press "Search"
    Then I should see empty posts search result
    And I should see empty questions search result

  Scenario: Do no search unpublished posts
    Given I fill in "search" with "unpublished"
    When I press "Search"
    Then I should see empty posts search result
