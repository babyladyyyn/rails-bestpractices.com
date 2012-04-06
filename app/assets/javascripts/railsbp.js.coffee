$ ->
  unless typeof tags is "undefined"
    $("#post_tag_list, #question_tag_list, #answer_tag_list").autocomplete tags,
      multiple: true
      matchContains: true
      autoFill: true

  $.each $("pre code"), (i, element) ->
    $(element).addClass "prettyprint"
  prettyPrint()

  $("abbr.timeago").timeago()

  $votes = $(".post .vote-info")
  console.log($votes)
  console.log($votes.length)
  if $votes.length > 0
    $(window).scroll ->
      if $(this).scrollTop() > 230
        $votes.css "margin-top", $(this).scrollTop() - 230
      else
        $votes.css "margin-top", 0

  $(".collapse").click ->
    $(this).parents("h3").next().hide()
    $(this).hide()
    $(this).next().show().css "display", "inline-block"
    false
  $(".expand").click ->
    $(this).parents("h3").next().show()
    $(this).hide()
    $(this).prev().show()
    false

  $(".leave-comment").click ->
    $form = $(this).parent().next()
    if $form.hasClass("hide")
      $form.removeClass "hide"
    else
      $form.addClass "hide"
    false

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
