$(document).ready(function(){

  $( "form#new_user" ).submit(function(submitform) {
     $( ".reviewing-application" ).show();
     var form = this;
      submitform.preventDefault();
      setTimeout(function () {
          form.submit();
      }, 3500);
  });


  
});