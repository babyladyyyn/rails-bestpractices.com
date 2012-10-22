$ ->
  $(".leave-comment").click ->
    $form = $(this).parent().next()
    if $form.hasClass("hide")
      $form.removeClass "hide"
    else
      $form.addClass "hide"
    false
