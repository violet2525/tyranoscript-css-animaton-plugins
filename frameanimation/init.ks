[iscript]
if(tf.skt_pnt === undefined){
    tf.skt_pnt = {}
}
// ブランクイメージ
if(mp.blank_image === "" || mp.blank_image === undefined){
    tf.skt_pnt.blank_image = "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAECAYAAACp8Z5+AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAABdJREFUeNpi/P//PwMyYGJAA4QFAAIMAMaOAwX2faROAAAAAElFTkSuQmCC"
}else{
    tf.skt_pnt.blank_image = mp.blank_image
}

[endscript]

;====================================
; マクロ定義
;====================================

;------------------------------------
; アニメーション定義
;------------------------------------
[macro name="blink_animation"]
[iscript]
//必須属性チェック
if(mp.name === "" || mp.name === undefined){
    alert("name属性は必須です。アニメーションさせるキャラクターの名前を指定してください。")
}
if(mp.part === "" || mp.part === undefined){
    alert("part属性は必須です。アニメーションさせるパーツ名を指定してください。")
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
mp.animation = mp.name + "_" + mp.part
var normal = "@keyframes " + mp.animation + " { " + anime + " } "
var webkit = "@-webkit-keyframes " + mp.animation + " { " + anime + " } "
var mozila = "@-moz-keyframes " + mp.animation + " { " + anime + " } "
var opera = "@-o-keyframes " + mp.animation + " { " + anime + " } "

//アニメーションをクラスに紐づけ
var chara = "." + mp.name + " img." + mp.part + "{ "
chara += " object-fit: cover;"
chara += " object-position: 0% 0%; }" 
chara += " ." + mp.name + " ." + mp.part + ".blink{ "
chara += " -webkit-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " -moz-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " -o-animation: " + mp.animation + " " + second + " steps(1) 0s infinite; "
chara += " animation: " + mp.animation + " " + second + " steps(1) 0s infinite; } "

$("<style>" + normal + webkit + mozila + opera + chara + "</style>").appendTo("head")
[endscript]
[endmacro]


;------------------------------------
; アニメーション開始
;------------------------------------
[macro name="blink_start"]
[iscript]
//必須属性チェック
if(mp.name === "" || mp.name === undefined){
    alert("name属性は必須です。キャラクター名を指定してください。")
}
if(mp.part === "" || mp.part === undefined){
    alert("part属性は必須です。キャラクター名を指定してください。")
}

var selecter = "." + mp.name + " img." + mp.part

$(selecter).addClass("blink")
//srcは一旦data-srcに退避
$(selecter).attr("data-src", $(selecter).attr("src"))
$(selecter).attr("src", tf.skt_pnt.blank_image)
$(selecter + ".blink").css("background",  "url(" + $(selecter).attr("data-src") + ") 0 0 no-repeat")
[endscript]
[endmacro]

;------------------------------------
; アニメーション終了
;------------------------------------
[macro name="blink_end"]
[iscript]
//必須属性チェック
if(mp.name === "" || mp.name === undefined){
    alert("name属性は必須です。キャラクター名を指定してください。")
}
if(mp.part === "" || mp.part === undefined){
    alert("part属性は必須です。キャラクター名を指定してください。")
}

var selecter = "." + mp.name + " img." + mp.part

$(selecter + ".blink").css("background",  "none")
//srcがブランクイメージならdata-srcに対比した画像をsrcにセット
$(selecter).attr("src", ($(selecter).attr("src") === tf.skt_pnt.blank_image ? $(selecter).attr("data-src") : $(selecter).attr("src")))
$(selecter).removeClass("blink")
[endscript]
[endmacro]

[return]