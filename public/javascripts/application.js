$(function() {
  // tag list auto complete
  if (typeof tags != 'undefined') {
    $('#post_tag_list, #question_tag_list, #answer_tag_list').autocomplete(tags, {
      multiple: true,
      matchContains: true,
      autoFill: true
    });
  }
  // remove the beginning spaces in <pre><code> </code></pre>
  $.each($('pre code'), function(i, element) {
    $(element).addClass('prettyprint');
  });
  // pretty print the wikistyle pre code
  prettyPrint();

  $(window).scroll(function() {
    $votes = $('.vote-info >div');
    if ($(this).scrollTop() > 230) {
      $votes.css('margin-top', $(this).scrollTop() - 230);
    } else {
      $votes.css('margin-top', 0);
    }
  });

  $('.collapse').click(function() {
    $(this).parents('h3').next().hide();
    $(this).hide();
    $(this).next().show().css('display', 'inline-block');
    return false;
  });
  $('.expand').click(function() {
    $(this).parents('h3').next().show();
    $(this).hide();
    $(this).prev().show();
    return false;
  });

  $('.leave-comment').click(function() {
    var $form = $(this).parent().next();
    if ($form.hasClass('hide')) {
      $form.removeClass('hide');
    } else {
      $form.addClass('hide');
    }
    return false;
  });
});
