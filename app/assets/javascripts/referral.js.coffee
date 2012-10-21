$ ->
  $.getJSON "http://referral.herokuapp.com/websites/5/refs?position=web&jsoncallback=?", (refs) ->
    $referrals = $(".referrals-section")
    $.each refs, (i, ref) ->
      $img = $("<img/>").attr("src", ref.image_url)
      $link = $("<a/>").attr("href", ref.url).text(ref.title)
      $text = $("<p/>").text(ref.description)
      $referral = $("<div/>").addClass("referral")
      $referral.append($img).append($link).append($text).appendTo($referrals)
