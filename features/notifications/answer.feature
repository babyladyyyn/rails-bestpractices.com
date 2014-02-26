Feature: Answer an question

  Background:
    Given a user "richard" exists with login: "richard"
    And a question "first question" exists with user: user "richard", title: "first question"
    And a question_body exists with question: question "first question", body: "first question"
    And I am already signed in as "flyerhzm"
    And I follow "Questions"
    And I follow "first question"

  Scenario: Successful answer
    Given I fill in "answer_answer_body_attributes_body" with "good question" under "Your Answer"
    When I press "Post Your Answer"
    Then "richard@gmail.com" should receive an email

  Scenario: Not notify if user doesn't select global email
    Given I fill in "answer_answer_body_attributes_body" with "good question" under "Your Answer"
    And a notification_setting exists with user: user "richard", name: "global_email", value: "0"
    And a notification_setting exists with user: user "richard", name: "answer_question", value: "1"
    When I press "Post Your Answer"
    Then "richard@gmail.com" should receive no email

  Scenario: Not notify if user doesn't want
    Given I fill in "answer_answer_body_attributes_body" with "good question" under "Your Answer"
    And a notification_setting exists with user: user "richard", name: "global_email", value: "1"
    And a notification_setting exists with user: user "richard", name: "answer_question", value: "0"
    When I press "Post Your Answer"
    Then "richard@gmail.com" should receive no email

