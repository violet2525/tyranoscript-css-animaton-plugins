
;メッセージレイヤ設定
[position layer="message0" page="fore" left="0" top="340" width="960" height="200" opacity="175" marginl="20" margint="10" marginr="20" marginb="10"]
;フォント設定
[font size="24" color="0xffffff" bold="true" edge="0x000000"]

[plugin name="frameanimation" blank_image="./data/others/plugin/frameanimation/image/blank.png"]

;繰り返し用ラベル
*start

;キャラクターと差分パーツの定義
[chara_new name="usagi" storage="../others/plugin/frameanimation/image/u_base.png"]
[chara_layer name="usagi" part="ear" id="1" storage="../others/plugin/frameanimation/image/u_ear01.png"]
[chara_layer name="usagi" part="ear" id="2" storage="../others/plugin/frameanimation/image/u_ear02.png"]
[chara_layer name="usagi" part="ear" id="3" storage="../others/plugin/frameanimation/image/u_ear03.png"]
;↓これがアニメーションするパーツ
[chara_layer name="usagi" part="ear" id="4" storage="../others/plugin/frameanimation/image/u_ear04.png"]    
;↓これがアニメーションするパーツ（デフォルト）
[chara_layer name="usagi" part="eye" id="3" storage="../others/plugin/frameanimation/image/u_eye03.png"]    
[chara_layer name="usagi" part="eye" id="2" storage="../others/plugin/frameanimation/image/u_eye02.png"]
[chara_layer name="usagi" part="eye" id="1" storage="../others/plugin/frameanimation/image/u_eye01.png"]
[chara_layer name="usagi" part="mouth" id="1" storage="../others/plugin/frameanimation/image/u_mouth01.png"]
[chara_layer name="usagi" part="mouth" id="2" storage="../others/plugin/frameanimation/image/u_mouth02.png"]
;↓これがアニメーションするパーツ
[chara_layer name="usagi" part="mouth" id="3" storage="../others/plugin/frameanimation/image/u_mouth03.png"]    

;アニメーションの定義※必ず[chara_show]より前に記述すること
[iscript]
tf.ear = [
    ["0%", 1],
    ["25%", 2],
    ["50%", 3],
    ["75%", 2],
    ["100%", 1]
]
tf.eye = [
    ["0%", 1],
    ["20%", 2],
    ["25%", 1],
    ["80%", 2],
    ["85%", 1],
    ["90%", 2],
    ["95%", 1],
    ["100%", 1]
]
tf.mouth = [
    ["0%", 1],
    ["80%", 2],
]
[endscript]
;目のアニメーション設定
[blink_animation anime="&tf.ear" w="400" name="usagi" part="ear" s="5"]
;耳のアニメーション設定
[blink_animation anime="&tf.eye" w="400" name="usagi" part="eye" s="6"]
;口のアニメーション設定
[blink_animation anime="&tf.mouth" w="400" name="usagi" part="mouth" s="2"]


;メッセージレイヤ表示
[layopt layer="message0" visible="true"]
[cm]
キャラクター差分パーツアニメーションプラグインの説明用シナリオです。[l][r]
クリックでキャラクターを表示し、目のアニメーション開始[p]

;キャラクター登場
[chara_show name="usagi" left="0" top="10"]

;目のアニメーションスタート（※[chara_show]の後に記述）
[blink_start name="usagi" part="eye"]

クリックで耳のアニメーション開始[p]

;耳のパーツをアニメーションパーツに変更し、アニメーション開始
[chara_part  name="usagi" ear="4"]
[blink_start name="usagi" part="ear"]

クリックで口のアニメーション開始[p]

;口のパーツをアニメーションパーツに変更し、アニメーション開始
[chara_part  name="usagi" mouth="3"]
[blink_start name="usagi" part="mouth"]

クリックで口のアニメーションを停止し、アニメーションしないパーツに変更[p]

;口のアニメーション停止、非アニメーションパーツに変更
[blink_end name="usagi" part="mouth"]
[chara_part name="usagi" mouth="2"]

クリックで最初に戻ります。[p]
[free layer="0" name="usagi"]
[jump target="*start"]

[s]