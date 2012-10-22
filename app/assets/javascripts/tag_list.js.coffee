$ ->
  $("#post_tag_list, #question_tag_list, #answer_tag_list").autocomplete tags,
    multiple: true
    matchContains: true
    autoFill: true
