

function buildHTML(data){

    var html = `<div class="message">
                  <div class="upper-message">
                    <div class="upper-message__user-name">
                      ${data.user_name}
                    </div>
                    <div class="upper-message__content">
                      <p>${data.message}</p>
                    </div>
                    <div class="lower-message__created">
                      ${data.created_at}
                    </div>
                  </div>
                </div>`;
    return html;
  }

function scroll() {

    $('.message').animate({scrollTop: $('.message')[0].scrollHeight});

}


$(document).on('turbolinks:load', function(){
  $('#new-message').on('submit', function(e){
    e.preventDefault();
    var message = new FormData(this);
    var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: 'POST',
      // リクエスト。フォームに入力された値
      data: message,
      datatype: "json",
      processData: false,
      contentType: false
    }).done(function(data){
      // フォームで入力された値がjbuilderで返されたものがdataに入っている
      console.log(data);
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



