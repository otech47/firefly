$(function () {

  setTimeout(function() {
    var initSize = $('#bgvid').outerHeight();
    $('#h').css("height", initSize); 
  }, 1000);
  
  $( window ).resize(function() {
    var videoSize = $('#bgvid').outerHeight();

    $('#h').css("height", videoSize); 
  });

  $('#menuToggle, .menu-close').on('click', function(){
    $('#menuToggle').toggleClass('active');
    $('body').toggleClass('body-push-toleft');
    $('#theMenu').toggleClass('menu-open');
  });
  
});