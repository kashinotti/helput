$(document).on('turbolinks:load', function(){
  $(function(){
    $('#hamburger-icon').on('click', function(e) {
      $('#hamburger-icon, #hamburger-nav').toggleClass('show');
    });
  });
});