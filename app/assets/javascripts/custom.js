$(document).on('turbolinks:load',function () {
  $('#noti_Counter')
    .css({ opacity: 0 })
    .text($('#noti_count').val())
    .css({ top: '-10px' })
    .animate({ top: '-2px', opacity: 1 }, 500);
  $('#noti_Button').click(function () {
    $('#noti_Button').css('background-color', '#FFF');
    });
    $('#noti_Counter').fadeOut('slow');
  });
  $(document).click(function () {
    $('#notifications').hide();
    if ($('#noti_Counter').is(':hidden')) {
      $('#noti_Button').css('background-color', '#2E467C');
    }
  });
});
