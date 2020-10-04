window.addEventListener('load', function () {
  if (!$('#card_form')[0]) return false;
  
  Payjp.setPublicKey("pk_test_a26d6cb64b232098d22d8d25");

  const regist_button = $("#regist_card");

  regist_button.on("click", function (e) { 
    e.preventDefault();

    const card = {
    number: document.getElementById("card_number_form").value,
    cvc: document.getElementById("cvc_form").value,
    exp_month: document.getElementById("exp_month_form").value,
    exp_year: document.getElementById("exp_year_form").value,
    };

    Payjp.createToken(card, (status, response) => {

      if (status === 200) {
        alert("カードを登録しました");
        $("#card_token").append(
          `<input type="hidden" name="payjp_token" value=${response.id}>`
        );

        $("#card_number_form").removeAttr("name");
        $("#cvc_form").removeAttr("name");
        $("#exp_month_form").removeAttr("name");
        $("#exp_year_form").removeAttr("name");

        $('#card_form')[0].submit();
      } else {
        alert("カード情報が正しくありません。");
        regist_button.prop('disabled', false);
      }


    });
  }); 
});