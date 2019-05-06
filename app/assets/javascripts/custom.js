$(document).on('turbolinks:load',function () {
  $('#noti_counter')
    .css({ opacity: 0 })
    .text($('#noti_counter').val())
    .css({ top: '-10px' })
    .animate({ top: '-2px', opacity: 1 }, 500);
  $('#noti_Button').click(function () {
    $('#noti_Button').css('background-color', '#FFF');
    });
    $('#noti_counter').fadeOut('slow');
  });
  $(document).click(function () {
    if ($('#noti_counter').is(':hidden')) {
      $('#noti_Button').css('background-color', '#2E467C');
    }
});
