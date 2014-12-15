$(function () {

  //set initial size
  setTimeout(function() {
    var initSize = $('#bgvid').outerHeight();
    $('#h').css("height", initSize); 
  }, 1000);
  
  //if resize change size
  $( window ).resize(function() {
    var videoSize = $('#bgvid').outerHeight();

    $('#h').css("height", videoSize); 
  });

  //side menu
  $('#menuToggle, .menu-close').on('click', function(){
    $('#menuToggle').toggleClass('active');
    $('body').toggleClass('body-push-toleft');
    $('#theMenu').toggleClass('menu-open');
  });

  //validate observer registration
  $("#new_observer").validate({
    rules: {
      "observer[email]": {
        required: true,
        email: true
      },
      "observer[name]": "required"
    },
    messages: {
      "observer[name]": "Please enter your name",
      "observer[email]": "Please enter a valid email address"
    }
  });
  
});