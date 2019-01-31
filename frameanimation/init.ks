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
mp.blink = {}
mp.blink[mp.name] = {
    part: {},
    storage: {}
}
var part = TYRANO.kag.stat.charas[mp.name]["_layer"]
//part指定ありの場合
Object.keys(mp).forEach(function(p){
    if(part[p]){
        if(part[p][mp[p]] === undefined){
            alert(p + "=" + mp[p] + "はありません") 
            return false
        }
        part[p].current_part_id = mp[p]
    }
})
Object.keys(part).forEach(function (p){
    mp.blink[mp.name].part[p] = part[p].current_part_id
    mp.blink[mp.name].storage[p] = "./data/fgimage/" + part[p][mp.blink[mp.name].part[p]].storage
})
[endscript]
[chara_show *]
[iscript]
Object.keys(mp.blink[mp.name].part).forEach(function (p) {
    $("." + mp.name + " img." + p).addClass(mp.blink[mp.name].part[p])
    var selecter = "." + mp.name + " img." + p + "." + mp.blink[mp.name].part[p]
    $(selecter + "." + mp.blink[mp.name].part[p]).css("background",  "url(" + mp.blink[mp.name].storage[p] + ") 0 0 no-repeat")
    $(selecter).attr("src", f.frame_animation.blank_image)
})
[endscript]
[endmacro]

;------------------------------------
; パーツ指定
;------------------------------------
[macro name="fa_chara_part"]
[iscript]
if($.find("." + mp.name).length == 0){
    mp.is_none = true
    Object.keys(mp).forEach(function (p) {
        if(TYRANO.kag.stat.charas[mp.name]["_layer"][p] !== undefined){
            TYRANO.kag.stat.charas[mp.name]["_layer"][p]["current_part_id"] = mp[p]
        }
    })
}else{
    if(mp.blink === undefined){
        mp.blink = {}
    }
    //各パーツのID取得
    mp.blink[mp.name] = {
        part: {},
        storage: {}
    }
    Object.keys(mp).forEach(function (p) {
        var part = TYRANO.kag.stat.charas[mp.name]._layer[p]
        if(part !== undefined){
            var old_storage = "./data/fgimage/" + part[part.current_part_id].storage

            if(part[mp[p]] === undefined){
                alert(p + "=" + mp[p] + "はありません") 
                return false
            }
            mp.blink[mp.name].part[p] = mp[p]
            mp.blink[mp.name].storage[p] = "./data/fgimage/" + part[mp[p]].storage

            var selecter = "." + mp.name + " img." + p
            if($.find(selecter).length > 0){
                TYRANO.kag.preload(old_storage, function () {
                    $(selecter).attr("src", old_storage)
                    $(selecter).css("background",  "none")
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
                })
            }
        }  
    })
}
[endscript]
[chara_part * cond="mp.is_none === undefined"]
[iscript]
if(mp.is_none !== undefined){
    //何もしない
}else{
    var cnt = 0
    Object.keys(mp.blink[mp.name].part).forEach(function (p) {
        $("." + mp.name + " img." + p).addClass(mp.blink[mp.name].part[p])
        var selecter = "." + mp.name + " img." + p + "." + mp.blink[mp.name].part[p]
        var part = TYRANO.kag.stat.charas[mp.name]._layer[p]
        var src = "./data/fgimage/" + part[part.current_part_id].storage
        $(selecter).css("background",  "url(" + src + ") 0 0 no-repeat")
        $(selecter).attr("src", f.frame_animation.blank_image)
    })
}
[endscript]
[endmacro]

[return]
