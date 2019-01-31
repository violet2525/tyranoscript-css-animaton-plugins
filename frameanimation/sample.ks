
;メッセージレイヤ設定
[position layer="message0" page="fore" left="0" top="340" width="960" height="200" opacity="175" marginl="20" margint="10" marginr="20" marginb="10"]
;フォント設定
[font size="24" color="0xffffff" bold="true" edge="0x000000"]

[plugin name="frameanimation" blank_image="./data/others/plugin/frameanimation/image/blank.png"]

;繰り返し用ラベル
*start

;キャラクターと差分パーツの定義
[chara_new name="usagi" storage="../others/plugin/frameanimation/image/u_base.png"]
[chara_layer name="usagi" part="ear" id="aaa" storage="../others/plugin/frameanimation/image/u_ear01.png"]
[chara_layer name="usagi" part="ear" id="bbb" storage="../others/plugin/frameanimation/image/u_ear02.png"]
[chara_layer name="usagi" part="ear" id="ccc" storage="../others/plugin/frameanimation/image/u_ear03.png"]
;↓これがアニメーションするパーツ
[chara_layer name="usagi" part="ear" id="ddd" storage="../others/plugin/frameanimation/image/u_ear04.png"]    
;↓これがアニメーションするパーツ（デフォルト）
[chara_layer name="usagi" part="eye" id="ccc" storage="../others/plugin/frameanimation/image/u_eye03.png"]    
[chara_layer name="usagi" part="eye" id="bbb" storage="../others/plugin/frameanimation/image/u_eye02.png"]
[chara_layer name="usagi" part="eye" id="aaa" storage="../others/plugin/frameanimation/image/u_eye01.png"]
[chara_layer name="usagi" part="mouth" id="aaa" storage="../others/plugin/frameanimation/image/u_mouth01.png"]
[chara_layer name="usagi" part="mouth" id="bbb" storage="../others/plugin/frameanimation/image/u_mouth02.png"]
;↓これがアニメーションするパーツ
[chara_layer name="usagi" part="mouth" id="ccc" storage="../others/plugin/frameanimation/image/u_mouth03.png"]    

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
;耳のアニメーション設定
[fa_animation anime="&tf.ear" w="400" name="usagi" part="ear" s="5" id="ddd"]
;目のアニメーション設定
[fa_animation anime="&tf.eye" w="400" name="usagi" part="eye" s="6" id="ccc"]
;口のアニメーション設定
[fa_animation anime="&tf.mouth" w="400" name="usagi" part="mouth" s="2" id="ccc"]


;メッセージレイヤ表示
[layopt layer="message0" visible="true"]
[cm]
キャラクター差分パーツアニメーションプラグインの説明用シナリオです。[l][r]
クリックでキャラクターを表示し、目のアニメーション開始[p]

;キャラクター登場
[fa_chara_show name="usagi" left="0" top="10" ear="ddd"]

;目のアニメーションスタート（※[chara_show]の後に記述）
;[fa_start name="usagi" part="eye"]

クリックで耳のアニメーション開始[p]

;耳のパーツをアニメーションパーツに変更し、アニメーション開始
[fa_chara_part  name="usagi" ear="ddd"]
;[fa_start name="usagi" part="ear"]

クリックで口のアニメーション開始[p]

;口のパーツをアニメーションパーツに変更し、アニメーション開始
[fa_chara_part  name="usagi" mouth="ccc"]
;[fa_start name="usagi" part="mouth"]

クリックで口のアニメーションを停止し、アニメーションしないパーツに変更[p]

;口のアニメーション停止、非アニメーションパーツに変更
;[fa_end name="usagi" part="mouth"]
[fa_chara_part name="usagi" mouth="bbb"]

クリックで最初に戻ります。[p]
[free layer="0" name="usagi"]
[jump target="*start"]

[s]