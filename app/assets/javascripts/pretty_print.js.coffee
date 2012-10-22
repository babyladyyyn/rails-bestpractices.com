$ ->
  $.each $("pre code"), (i, element) ->
    $(element).addClass "prettyprint"
  prettyPrint()
