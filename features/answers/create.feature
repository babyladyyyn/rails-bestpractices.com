Feature: Answer an question

  Background:
    Given a user "richard" exists with login: "richard"
    And a question "first question" exists with user: user "richard", title: "first question"
    And a question_body exists with question: question "first question", body: "first question"
    And I am already signed in as "flyerhzm"
    And I follow "Questions" / "first question"

  Scenario: Successful answer
    Given I fill in "answer_answer_body_attributes_body" with "good question" under "Your Answer"
    When I press "Post Your Answer"
    Then I should see "Answer was successfully created"
    And I should see "Answered by flyerhzm"
    And I should see "good question"

  Scenario: Unsuccessful answer
    Given I fill in "answer_answer_body_attributes_body" with "" under "Your Answer"
    When I press "Post Your Answer"
    Then I should be on answer question failure page
    And I should see "can't be blank"
