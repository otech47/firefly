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

    $('[data-toggle="tooltip"]').tooltip({'placement': 'top', 'html': 'true'});


  //validate observer registration
  $.validator.addMethod("checkemail",
    function(value, element) {
        var result = false;
        $.ajax({
            type:"GET",
            async: false,
            url: "/api/v1/validate/observer?email=" + encodeURI(value),
            success: function(msg) {
                result = (msg['check'] == "bad") ? false : true;
            }
        });
        return result;
    },
    "Ticket with this email already exists."
  );

  $("#new_observer").validate({
    rules: {
      "observer[email]": {
        required: true,
        checkemail: true
      },
      "observer[name]": "required"
    },
    messages: {
      "observer[name]": "Please enter your name",
      "observer[checkemail]": "Ticket with this email already exists"
    }
  });

});
