$ ->
  $votes = $(".post .vote-info")
  if $votes.length > 0
    $(window).scroll ->
      if $(this).scrollTop() > 230
        $votes.css "margin-top", $(this).scrollTop() - 230
      else
        $votes.css "margin-top", 0
