$(window).on('load', ()=> {
  const buildFileField = (index)=> {
    if ($('.content').length < 5) {
    var html = `
                  <li class="file_${index}" data-index="${index}">
                    <input class="js-file" type="file" 
                    name="item[item_images_attributes][${index}][image_url]" 
                    id="item_item_images_attributes_${index}_image_url">
                  </li>
                  <label class="image-label" for="item_item_images_attributes_${index}_image_url">
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

  let fileIndex = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,
                  30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,
                57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);
  console.log($('.content').length)
  if ($('li').length != 1) {
    fileIndex.splice(0, $('.content').length);
  }
  console.log(fileIndex)

  $('.hidden-destroy').hide();

  $('#image-box').on('change', '.js-file', function(e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('image_url', blobUrl);
    } else {  
      $(`.image-label`).remove();
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#image-box').append(buildFileField(fileIndex[0] + 1));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length]);
    }
  });

  $('#image-box').on('click', '.js-remove', function() {
    const targetIndex = $(this).parent().data('index')
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);

    if ($('li').length != 1) {
      fileIndex.splice(0, $('.content').length);
    }
    
    if (hiddenCheck) hiddenCheck.prop('checked', true);
    $(this).parent().parent().remove();
    $(`.file_${targetIndex}`).remove();
     if ( $('.content').length == 4) {
     $('#image-box').append(buildFileField(fileIndex[0]))
     };
  });
});