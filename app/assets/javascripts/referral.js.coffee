$ ->
  $.getJSON "http://referral.herokuapp.com/websites/5/refs?name=web&jsoncallback=?", (refs) ->
    $referrals = $(".referrals-section")
    $.each refs, (i, ref) ->
      $img = $("<img/>").attr("src", ref.image_url)
      $link = $("<a/>").attr("href", "http://referral.herokuapp.com/websites/5/refs/" + ref.id + "?name=web").text(ref.title)
      $text = $("<p/>").text(ref.description)
      $referral = $("<div/>").addClass("referral")
      $referral.append($img).append($link).append($text).appendTo($referrals)
