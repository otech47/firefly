$(function () {

  $('select').select2();

  var isMobile = {
    Android: function() {
      return navigator.userAgent.match(/Android/i);
    },
    BlackBerry: function() {
      return navigator.userAgent.match(/BlackBerry/i);
    },
    iOS: function() {
      return navigator.userAgent.match(/iPhone|iPad|iPod/i);
    },
    Opera: function() {
      return navigator.userAgent.match(/Opera Mini/i);
    },
    Windows: function() {
      return navigator.userAgent.match(/IEMobile/i);
    },
    any: function() {
      return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
    }
  };

  if (isMobile.any()) {
    $('#bgvid').remove();
  };

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
      "observer[name]": {
        required: true
      }
    },
    messages: {
      "observer[name]": "Please enter your name",
      "observer[checkemail]": "Ticket with this email already exists"
    }
  });



  $.validator.addMethod("checkteam",
    function(value, element) {
        var result = false;
        $.ajax({
            type:"GET",
            async: false,
            url: "/api/v1/validate/team?teamname=" + encodeURI(value),
            success: function(msg) {
                result = (msg['check'] == "bad") ? false : true;
            }
        });
        return result;
    },
    "A team with this name already exists"
  );

  $(".remote_team_create").validate({
    rules: {
      "team[name]": {
        required: true,
        checkteam: true
      }
    },
    messages: {
      "team[name]": "Please enter a unique team name"
    }
  });

  $('.datatable').DataTable({
    // ajax: ...,
    // autoWidth: false,
    // pagingType: 'full_numbers',
    // processing: true,
    // serverSide: true,

    // Optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about available options.
    // http://datatables.net/reference/option/pagingType
  });

  //adding team member
  $(".try-to-add-member").click(function(){

    $('.waiting-adding-member').show();

    var member_email = $(".new-member-email-address").val();
    var team_id = $(".team-id-get-it").val();

    //check team member account
    $.ajax({
      type: "GET",
      url: "/api/v1/team/"+team_id,
      success: function(data) {
        console.log(data);

        if (data.data.member_count < 5) {

          //add the member
          $.ajax({
            type: "GET",
            url: "/api/v1/process/lookup/hacker?email="+member_email+"&team_id="+team_id,
            success: function(data){

              if (data.status == '200') {
                $('.waiting-adding-member').hide();
                $('.adding-member-message .in span').html(data.data.name);
                $('.adding-member-message .in').show();

                $('.team-members-here').append('<div class="col-md-2"><a href="/hacker/'+data.data.id+'"><img alt="'+data.data.name+'" class="img-thumbnail" height="512" src="http://gravatar.com/avatar/'+data.data.email_hash+'?secure=false&amp;size=512" style="width: 100%;" width="512"><h3>'+data.data.name+'</h3></a></div>');

              } else {
                $('.waiting-adding-member').hide();
                $('.adding-member-message .out span').html(member_email);
                $('.adding-member-message .out').show();
              };

            },
            failure: function(errMsg) {
              alert(errMsg);
            }
          });

        } else {

          $('.waiting-adding-member').hide();
          $('.adding-member-message .max span').html(data.data.team.name);
          $('.adding-member-message .max').show();

        };
      },
      failure: function(errMsg) {
        alert(errMsg);
      }
    });

  });

  $(".close-add-member").click(function(){
    $('.new-member-email-address').val('');
    $('.adding-member-message .in').hide();
    $('.adding-member-message .out').hide();
    $('.adding-member-message .max').hide();
  });

  //invite participant
  $(".dude-invite-me").click(function(){
    var hacker_id = $('.p_invi_hacker_id').val();
    var by_who = $('.p_invi_by_who').val();

    $.ajax({
      type: "GET",
      url: "/api/v1/team/invite/"+by_who+"/"+hacker_id,
      success: function(data){

        if (data.status == '200') {
          $('#profile-invite-member').modal('toggle');

          $('.yo-no-se h2').hide();
          $('.yo-no-se button').hide();
          $('.yo-no-se h3').show();
        } else {
          alert('Nothing Happen');
        };

      },
      failure: function(errMsg) {
        alert(errMsg);
      }
    });
  });

});
