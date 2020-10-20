window.addEventListener('load',function(){
  $('#new_comment').on('submit', function(e){
    e.preventDefault()
    var formData = new FormData(this);
    var url = $(this).attr('action');

    function buildHTML(comment){
      if (comment.item_seller == comment.user_id){
      var html = `<div class="messages_box__message">
                    <div class="user-info">
                      <div class="user-info__img"></div>
                        <div class="seller">出品者</div>
                    </div>
                    <div class="message-info">
                      <div class="message-info__name">
                        ${comment.user_name}
                      </div>
                      <div class="message-info__text">
                        <div class="message-info__text__message">
                          ${comment.message }
                        </div>
                        <div class="message-info__text__time">
                          ${comment.created_at}
                        </div>
                      </div>
                    </div>
                  </div>
                  `
      }else{            
      var html = `<div class="messages_box__message">
                    <div class="user-info">
                      <div class="user-info__img"></div>
                    </div>
                    <div class="message-info">
                      <div class="message-info__name">
                        ${comment.user_name}
                      </div>
                      <div class="message-info__text">
                        <div class="message-info__text__message">
                          ${comment.message }
                        </div>
                        <div class="message-info__text__time">
                          ${comment.created_at}
                        </div>
                      </div>
                    </div>
                  </div>
                  `
    }
      return html;
    }

      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
        .done(function(comment_data){
          let html = buildHTML(comment_data);
          $('.messages_box').append(html);
          $('#comment_body').val('');
          $('.commentBtn').prop('disabled', false);
        })cv
        .fail(function(comment_data) {
          alert("メッセージ送信に失敗しました");
        });
  });
})