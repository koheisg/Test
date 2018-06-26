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
  $("#modal-open").click(function(){
    //キーボード操作などにより、オーバーレイが多重起動するのを防止する
    $( this ).blur() ;  //ボタンからフォーカスを外す
    if( $( "#modal-overlay" )[0] ) return false ;   //新しくモーダルウィンドウを起動しない (防止策1)
    //if($("#modal-overlay")[0]) $("#modal-overlay").remove() ;   //現在のモーダルウィンドウを削除して新しく起動する (防止策2)

    //オーバーレイを出現させる
    $( "body" ).append( '<div id="modal-overlay"></div>' ) ;
    $( "#modal-overlay" ).fadeIn( "slow" ) ;

    //コンテンツをセンタリングする
    centeringModalSyncer() ;

    //コンテンツをフェードインする
    $( "#modal-main" ).fadeIn( "slow" ) ;

    //[#modal-overlay]、または[#modal-close]をクリックしたら…
    $( "#modal-overlay,#modal-close" ).unbind().click( function(){

      //[#modal-main]と[#modal-overlay]をフェードアウトした後に…
      $( "#modal-main,#modal-overlay" ).fadeOut( "slow" , function(){

        //[#modal-overlay]を削除する
        $('#modal-overlay').remove() ;

      } ) ;

    } ) ;

  } ) ;

  //リサイズされたら、センタリングをする関数[centeringModalSyncer()]を実行する
  $( window ).resize( centeringModalSyncer ) ;

  //センタリングを実行する関数
  function centeringModalSyncer() {

    //画面(ウィンドウ)の幅、高さを取得
    var w = $( window ).width() ;
    var h = $( window ).height() ;

    // コンテンツ(#modal-main)の幅、高さを取得
    // jQueryのバージョンによっては、引数[{margin:true}]を指定した時、不具合を起こします。
    var cw = $( "#modal-main" ).outerWidth( {margin:true} );
    var ch = $( "#modal-main" ).outerHeight( {margin:true} );
    var cw = $( "#modal-main" ).outerWidth();
    var ch = $( "#modal-main" ).outerHeight();

    //センタリングを実行する
    $( "#modal-main" ).css( {"left": ((w - cw)/2) + "px","top": ((h - ch)/2) + "px"} ) ;

  }
} ) ;
