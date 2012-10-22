$ ->
  if $("#post_post_body_attributes_body").length > 0
    $("#post_post_body_attributes_body").before "<div id='wmd-button-bar'></div>"
    $("#post_post_body_attributes_body").after "<div id='wmd-preview' class='wikistyle'></div>"
    new WMDEditor
      input: "post_post_body_attributes_body"
      button_bar: "wmd-button-bar"
      preview: "wmd-preview"
      helpLink: "http://daringfireball.net/projects/markdown/syntax"
  if $("#question_question_body_attributes_body").length > 0
    $("#question_question_body_attributes_body").before "<div id='wmd-button-bar'></div>"
    $("#question_question_body_attributes_body").after "<div id='wmd-preview' class='wikistyle'></div>"
    new WMDEditor
      input: "question_question_body_attributes_body"
      button_bar: "wmd-button-bar"
      preview: "wmd-preview"
      helpLink: "http://daringfireball.net/projects/markdown/syntax"
  if $("#answer_answer_body_attributes_body").length > 0
    $("#answer_answer_body_attributes_body").before "<div id='wmd-button-bar'></div>"
    $("#answer_answer_body_attributes_body").after "<div id='wmd-preview' class='wikistyle'></div>"
    new WMDEditor
      input: "answer_answer_body_attributes_body"
      button_bar: "wmd-button-bar"
      preview: "wmd-preview"
      helpLink: "http://daringfireball.net/projects/markdown/syntax"
