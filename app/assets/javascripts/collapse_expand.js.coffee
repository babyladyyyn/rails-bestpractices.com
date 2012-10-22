$ ->
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
