$(window).on('load', ()=> {
  const buildFileField = (index)=> {
    if ($('li').length < 5) {
    var html = `
                  <li class="file_${index + 1}" data-index="${index + 1}">
                    <input class="js-file" type="file" 
                    name="item[item_images_attributes][${index + 1}][image_url]" 
                    id="item_item_images_attributes_${index + 1}_image_url">
                  </li>
                  <label class="image-label_${index + 1}" for="item_item_images_attributes_${index + 1}_image_url">
                    <div class="image-icon">
                    <i class="fas fa-camera icon"></i>
                    </div>
                  </label>
                `;
    } else {
      var html = ``
    }
    return html;
  }

  const buildImg = (index, url)=> {
    const html = `
                  <div class="content">
                    <img data-index="${index}" src="${url}" width="100px" height="100px"><br>
                    <div class="image-option" data-index="${index}">
                      <span class="js-remove">削除</span>
                    </div>
                  </div>
                  `;
    return html;
  }

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);
    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image_url', blobUrl);
    } else {  
      $(`.image-label_${targetIndex}`).remove();
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#image-box').append(buildFileField(targetIndex));
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index')
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    console.log(targetIndex)
    console.log(hiddenCheck)
    
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().parent().remove();
    $(`.file_${targetIndex}`).remove();
    $(`.image-label_${targetIndex}`).remove();
     if ($('li').length == 0 || $('li').length == 4) {
     $('#image-box').append(buildFileField(targetIndex))
     };
  });
});