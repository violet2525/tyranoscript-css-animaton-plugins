[iscript]
if(f.frame_animation === undefined){
    f.frame_animation = {}
}
// ブランクイメージ
if(mp.blank_image === "" || mp.blank_image === undefined){
    f.frame_animation.blank_image = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABdJREFUeNpi/P//PwMyYGJAA4QFAAIMAMaOAwX2faROAAAAAElFTkSuQmCC"
}else{
    f.frame_animation.blank_image = mp.blank_image
}

[endscript]

;====================================
; マクロ定義
;====================================

;------------------------------------
; アニメーション定義
;------------------------------------
[macro name="fa_animation"]
[iscript]
//必須属性チェック
if(mp.name === "" || mp.name === undefined){
    alert("name属性は必須です。アニメーションさせるキャラクターの名前を指定してください。")
}
if(mp.part === "" || mp.part === undefined){
    alert("part属性は必須です。アニメーションさせるパーツ名を指定してください。")
}
if(mp.id === "" || mp.id === undefined){
    alert("id属性は必須です。アニメーションさせるパーツのIDを指定してください。")
}
if(mp.anime === "" || mp.anime === undefined){
    alert("anime属性は必須です。アニメーション定義を配列形式で指定してください。")
}
if(mp.w === "" || mp.w === undefined){
    alert("w属性は必須です。1コマあたりの画像の横幅を指定してください。")
}

//秒数
var second = ""
if(mp.s === "" || mp.s === undefined){
     second = "4s"
}else if(parseInt(mp.s) === NaN){
    alert("s属性の値が不正です。数値を入力してください。")
}else{
    second = mp.s + "s"
}
//アニメーション定義
var anime = ""
for(var i = 0; i < mp.anime.length; i++){
    anime += mp.anime[i][0] + "{ background-position: " + ((parseInt(mp.anime[i][1] - 1)) * mp.w) * -1 + "px 0;} "
}
mp.animation = mp.name + "_" + mp.part + "_" + mp.id
var normal = " @keyframes " + mp.animation + " { " + anime + " } "
var webkit = " @-webkit-keyframes " + mp.animation + " { " + anime + " } "
var mozila = " @-moz-keyframes " + mp.animation + " { " + anime + " } "
var opera = " @-o-keyframes " + mp.animation + " { " + anime + " } "

//アニメーション開始までのスタイル
var chara_part = "." + mp.name + " img." + mp.part + "{ "
chara_part += " object-fit: cover;"
chara_part += " object-position: 0% 0%; }" 

//アニメーションをクラスに紐づけ
var chara = " ." + mp.name + " ." + mp.part + "." + mp.id + "{ "
chara += " -webkit-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " -moz-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " -o-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " animation: " + mp.animation + " " + second + " steps(1) 0s infinite; } "

if($.find("#frame-animation").length === 0){
    //CSSなし
    $("<style id='frame-animation'></style>").appendTo("head")
}
var csslist = document.styleSheets
var cssrules = csslist[csslist.length - 1]

var max = 0
for(var i = 0; i < cssrules.length; i++){
    if(cssrules[i].selectorText === "." + mp.name + " img." + mp.part){
        //セレクタ：キャラ名 img.パーツ名
        max = i
        break;
    }
}
//CSSセット
if(max === 0){
    $("#frame-animation").html($("#frame-animation").html() + chara_part)
}
$("#frame-animation").html($("#frame-animation").html() + normal + webkit + mozila + opera + chara)

[endscript]
[endmacro]


;------------------------------------
; キャラクター登場
;------------------------------------
[macro name="fa_chara_show"]
[iscript]
//パーツのデフォルトID取得
tf.blink_part = {}
Object.keys(TYRANO.kag.stat.charas[mp.name]["_layer"]).forEach(function (p){
    tf.blink_part[p] = TYRANO.kag.stat.charas[mp.name]["_layer"][p]["current_part_id"]
})
[endscript]
[chara_show *]
[iscript]
Object.keys(tf.blink_part).forEach(function (p) {
    $("." + mp.name + " img." + p).addClass(tf.blink_part[p])
    var selecter = "." + mp.name + " img." + p + "." + tf.blink_part[p]
    //srcは一旦data-srcに退避
    $(selecter).attr("data-src", $(selecter).attr("src"))
    $(selecter).attr("src", f.frame_animation.blank_image)
    $(selecter + "." + tf.blink_part[p]).css("background",  "url(" + $(selecter).attr("data-src") + ") 0 0 no-repeat")
})
delete tf.blink_part
[endscript]
[endmacro]

;------------------------------------
; パーツ指定
;------------------------------------
[macro name="fa_chara_part"]
[iscript]
//各パーツのID取得
tf.blink_part = {}
Object.keys(mp).forEach(function (p) {
    if(p === "name" || p === "time" || p === "wait" || p === "allow_storage" || p === "*"){
        // 何もしない
    }else{
        tf.blink_part[p] = mp[p]

        var selecter = "." + mp.name + " img." + p
        if($.find(selecter).length > 0){
            $(selecter).css("background",  "none")
            //srcがブランクイメージならdata-srcに対比した画像をsrcにセット
            $(selecter).attr("src", ($(selecter).attr("src") === f.frame_animation.blank_image ? $(selecter).attr("data-src") : $(selecter).attr("src")))
            //余計なクラスを削除
            var _class = $(selecter).attr("class")
            var classlist = _class.split(" ")
            for(var i = 0; i < classlist.length; i++){
                if(classlist[i] === p || classlist[i] === "part"){
                    //何もしない
                }else{
                    $(selecter).removeClass(classlist[i])
                }
            }
        }
    }  
})
[endscript]
[chara_part *]
[iscript]
Object.keys(tf.blink_part).forEach(function (p) {
    $("." + mp.name + " img." + p).addClass(tf.blink_part[p])
    var selecter = "." + mp.name + " img." + p + "." + tf.blink_part[p]
    //srcは一旦data-srcに退避
    $(selecter).attr("data-src", $(selecter).attr("src"))
    $(selecter).attr("src", f.frame_animation.blank_image)
    $(selecter + "." + tf.blink_part[p]).css("background",  "url(" + $(selecter).attr("data-src") + ") 0 0 no-repeat")
})
delete tf.blink_part
[endscript]
[endmacro]

[return]
