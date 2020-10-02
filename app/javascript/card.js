document.addEventListener('turbolinks:load', function () {
  if (!$('#card_form')[0]) return false;
  
  Payjp.setPublicKey("pk_test_a26d6cb64b232098d22d8d25");

  const regist_button = $("#regist_card");

  regist_button.on("click", function (e) { 
    e.preventDefault();
    console.log(this);    
  }); 
});