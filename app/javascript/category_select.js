document.addEventListener('turbolinks:load', function () {
  if (!$('.select-category')[0]) return false; //カテゴリのフォームが無いなら以降実行しない。

    function buildCategoryForm(categories) { // 子孫カテゴリのフォームを組み立てる
      let options = "";
      categories.forEach(function (category) { // カテゴリを一つずつ渡してoptionタグを一つずつ組み立てていく。
      options += `
                  <option value="${category.id}">${category.name}</option><br>
                 `;
    });

      const html = `
      <select class="select-category" id="parent-category" name="item[category_id]">
                    <option value="">選択してください</option>
                    ${options}
                  </select>
                   `;
      return html;
    }

    $(".sell-collection_select").on("change", ".select-category", function () { 
      const category_id = $(this).val();

    $.ajax({
      url: "/api/categories", 
      type: "GET",
      data: {
        category_id: category_id
      },
      dataType: 'json',
    }).done(function (categories) {
      console.log("success")
      console.log(categories)
      const html = buildCategoryForm(categories);
      console.log(html);
      $(".select-category:last").after(html);
    })
    .fail(function () {
      alert('error');
    })
  });
});