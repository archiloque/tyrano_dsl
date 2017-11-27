[_tb_system_call storage=system/_scene1.ks]

[cm  ]
[bg  storage="room.jpg"  time="1000"  ]
[chara_show  name="Bob"  time="1000"  wait="true"  ]
[tb_show_message_window  ]
[tb_start_text mode=1 ]
#Bob
Hello.[p]
This is a new game project.[p]
Blablablablabla[p]

[_tb_end_text]

[chara_mod  name="Bob"  time="600"  cross="true"  storage="chara/1/nyaa.png"  ]
[s  ]
[jump  storage="scene2.ks"  target=""  ]
