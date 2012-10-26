Feature: List notifications

  Background:
    Given a user "richard" exists with login: "richard"
    And a user "flyerhzm" exists with login: "flyerhzm"
    And a question "first question" exists with user: user "richard", title: "first question"
    And a question_body exists with question: question "first question", body: "first question"
    And an answer "first answer" exists with user: user "flyerhzm", question: question "first question"
    And an answer_body exists with answer: answer "first answer", body: "first answer"
    And a notification exists with user: user "richard", notifierable: the answer
    And I am already signed in as "richard"
    When I follow "1"
    Then I should see "flyerhzm"
    And I should see "first question"
