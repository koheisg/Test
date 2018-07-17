//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require data-confirm-modal
//= require flatpickr
//
// Locales can be included like so:
//= require flatpickr/l10n/ja

// const config = {
//   enableTime: true,
//   altFormat: "F j, Y",
//   dateFormat: "Y-m-d",
// }


//flatpickrの初期化
//flatpickr('#EventCalendar');
$('#EventCalendar').flatpickr();

// //flatpickrの初期化
// flatpickr('#EventCalendar',config

// $(function() {
//   var elems = getDOMElements();
//   var today = new Date();
//   var calendar = null;

//   Flatpickr.l10ns.default.weekdays.shorthand = [
//     "日", "月", "火", "水", "木", "金", "土"
//   ];

//   calendar = new Flatpickr(elems.flatpickr, {
//     "enableTime": true,
//     "defaultDate": today
//   });

//   function getDOMElements() {
//     return {
//       "flatpickr": document.getElementById("flatpickr")
//     };
//   }
// })
// ();