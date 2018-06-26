//= require jquery
//= require jquery_ujs
//=require_tree .
//= require flatpickr

//flatpickrの初期化
flatpickr('#EventCalendar');

//flatpickr.setDefaults({
//    enableTime: true,
//    dateFormat: "Y-m-d H:i",
//    "locale": 'ja',
//});

// '曜日'を日本語化
//flatpickr.init.prototype.l10n.weekdays.shorthand = toJPN.weekdays;

// '月'を日本語化
//flatpickr.init.prototype.l10n.months.longhand = toJPN.months;



$(function(){
  // $(".participate-button").each(function(i, participate) {
  //   console.log(participate);
  //   // participate.bind("click", function(){
  //   //   alert( $(this) );
  //   // });

  //   participate.click(function() {
  //       console.log('クリックされました！');
  //   });
  // });

  // $(".participate-button").click(function() {
  //       console.log('クリックされました！');
  //   });

  $(".participate-button").each(function(i) {
   $(this).click(function() {
      console.log('クリックされました！');
    });
});

});

