Feature: Save an answer

  Background:
    Given a user "richard" exists with login: "richard"
    And a user "flyerhzm" exists with login: "flyerhzm"
    And a question "first question" exists with user: user "richard", title: "first question"
    And a question_body exists with question: question "first question", body: "first question"
    And an answer "first answer" exists with question: question "first question", user: user "flyerhzm"
    And an answer_body exists with answer: answer "first answer", body: "first answer"
    And I am already signed in as "flyerhzm"
    And I follow "Questions" / "first question"
    And I follow "Edit"

  Scenario: Successfully update
    Given I fill in "answer_answer_body_attributes_body" with "good question"
    When I press "Save"
    Then I should see "Your Answer was successfully updated!"
    And I should see "good question"

  Scenario: Unsuccessfully update
    Given I fill in "answer_answer_body_attributes_body" with ""
    When I press "Save"
    Then I should be on update answer failure page
    And I should see "can't be blank"
