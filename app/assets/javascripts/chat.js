function buildHTML(chat){
    var html = `<div class="upper-message__user-name">
                  ${chat.user_name}
                </div>
                <div class="upper-message__content">
                  <p>${chat.message}</p>
                </div>
                <div class="lower-message__created">
                  ${chat.created_at}
                </div>`;
    return html;
  }

function scroll() {

    $('.messages').animate({scrollTop: $('.message')[0].scrollHeight});

}




$(document).on('turbolinks:load', function(){
  $('#new-message').on('submit', function(e){
    e.preventDefault();
    var message = new FormData(this);
    var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: 'POST',
      data: message,
      datatype: "json",
      processData: false,
      contentType: false
    }).done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html);
      $('.form_message').val("");
      $('.form_submit').prop('disabled', false);
    }).fail(function(data){
      alert('エラーが発生したためメッセージは送信できませんでした。');
       $('.form_submit').prop('disabled', false);
    });
  });
});



