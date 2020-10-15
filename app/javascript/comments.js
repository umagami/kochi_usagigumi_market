window.addEventListener('load',function(){
  $('.new_comment').on('submit', function(e){
    e.preventDefault()
    var formData = new FormData(this);
    var url = $(this).attr('action');

      $.ajax({
        url: url,
        type: "POST",
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
        .done(function(comment_data){
          console.log("ok")
          // var html = new_comment(comment_data);
          // $(".comment_box").append(html)
          // $('#comment_body').val("");
          // $('.comment_box').animate({ scrollTop: $('.comment_box')[0].scrollHeight});
        })
        .fail(function(comment_data) {
          alert("メッセージ送信に失敗しました");
        });
  });
})