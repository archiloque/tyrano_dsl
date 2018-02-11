[_tb_system_call storage=system/_scene1.ks]
[cm]
[bg storage="1.jpg" time="1000"]
*label_0
[chara_show name="Shinji" time="1000" wait="true" left="434" top="128" width="" height="" reflect="false"]
[tb_show_message_window]
[tb_start_text mode=1]
Hello!
[_tb_end_text]

[tb_start_text mode=1]
#Shinji
Hello!
[_tb_end_text]

[chara_mod name="Shinji" time="600" cross="true" storage="chara/1/1.png"]
[tb_hide_message_window]
[glink color="black" storage="scene2" target="" size="20" x="200" y="200" text="Yes !"]
[glink color="black" storage="scene3" target="label_1" size="20" x="200" y="300" text="No &quot;&quot;?"]
[s]

[chara_hide name="Shinji" time="1000" wait="true"]
[jump storage="scene2.ks" target=""]
