[_tb_system_call storage=system/_scene3.ks]
[cm]
[bg storage="1.jpg" time="1000"]
*label_2
[jump storage="scene3.ks" target="cond" cond="f.variable_1<10"]
[tb_eval  exp="f.variable_1+=20"  name="variable_1"  cmd="+="  op="t"  val="20"  val_2="undefined"]
[tb_start_text mode=1]
Hello from included scene!
[_tb_end_text]

[bg storage="2.jpg" time="1000"]
[jump storage="scene1.ks" target="label_3"]
