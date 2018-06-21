//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks

// flatpickrを起動させるinputのID *classでも可
// 当日以前の日付は表示させない
flatpickr("#EventCalendar", {
  minDate: "today"
  onReady: function() {
    // カレンダーがロードされた時の処理
  },
  onValueUpdate: function(selectedDates, dateStr) {
    // 値が変更された時の処理
    alert('日付が ' + dateStr + ' に変更されました !');

  },
  onClose: function(selectedDates, dateStr) {
    // 日付を選択し終えた時の処理
  },
  onChange: function(selectedDates, dateStr) {
    // 日付を変更し終えた時の処理

    // selectedDates : Fri Sep 22 2017 00:00:00 GMT+0900 (JST)
    // dateStr : 2017-09-22
  }

  enableTime: true, // タイムピッカーを有効
  enableSeconds: false, // '秒' を無効
  time_24hr: false, // 24時間表示
  dateFormat: "H:i", // 時間のフォーマット "時:分"
  // タイムピッカーのデフォルトタイム
  // 下記の場合はタイムピッカーを開いた時に '9:00'で表示
  defaultHour: 19, // 時
  defaultMinute: 0, // 分
  // defaultDate: '9:00' // 時間を予めセットする時の設定
});

//jQueryでflatpickrを使用
$("#EventCalendar").flatpickr(altInput: true,altFormat: "F j, Y",dateFormat: "Y-m-d",);

 var toJPN = {
               weekdays : ['日', '月', '火', '水', '木', '金', '土'],
               months: ['1月', '2月', '3月', '4月', '5月', '6月', '7月',
                         '8月', '9月', '10月', '11月', '12月'
                       ]
              };

// '曜日'を日本語化
flatpickr.init.prototype.l10n.weekdays.shorthand = toJPN.weekdays;

// '月'を日本語化
flatpickr.init.prototype.l10n.months.longhand = toJPN.months;

