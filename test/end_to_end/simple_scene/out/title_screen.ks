
;==============================
; タイトル画面
;==============================
[hidemenubutton]
[tb_keyconfig flag=0]


	;標準のメッセージレイヤを非表示
	[tb_hide_message_window]

	;タイトル表示
	[bg storage ="title.jpg"]

	*title



	;タイトル各種ボタン
	[glink text="New&nbsp;Game" x=600 y=370 target="*start"]
	[glink text="Load&nbsp;Game" x=600 y=470 target="*load"]



	[s]

	;-------ボタンが押されたときの処理

	*start


	[showmenubutton]


	[cm]
	[tb_keyconfig flag=1]

	@jump storage="scene1.ks"
	[s]

	;--------ロードが押された時の処理
	*load

	[cm]
	[showload]
	[jump target=*title]

	[s]

