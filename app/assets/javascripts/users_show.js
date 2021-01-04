/* global $*/
$(document).ready(function(){

  $('#tab-index .tab[id != tab1]').hide();

  $(document).on('click', '#tab-menu a', function(event) {
    $('#tab-index .tab').hide();
    $('#tab-menu .active').removeClass("active");
    $(this).addClass("active");
    $($(this).attr("href")).show();
    event.preventDefault();
  });
});