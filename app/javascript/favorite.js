window.addEventListener('load',function(){
  $('#new-favorite').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action")

    function buildHTML(favorite) {
      var html = `<div class="favorite">
                  ${favorite.count}
                  </div>
                  `
      return html
    }

    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.favorite').remove();
      $('.option__favorite').append(html);
    })
    .fail(function(data){
      alert("うんこ");
    })
    })
 })