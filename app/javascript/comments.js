$('.new_comment').on('submit', function(e){
  e.preventDefault()
  console.log(1234)
  var formData = new FormData(this);
  var url = $(this).attr('action');

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json'
    })
      .done(function(comment_data){
        var html = new_comment(comment_data);
        $(".comment_box").append(html)
        $('#comment_body').val("");
        $('.comment_box').animate({ scrollTop: $('.comment_box')[0].scrollHeight});
      })
      .fail(function() {
        alert("メッセージ送信に失敗しました");
      });
});