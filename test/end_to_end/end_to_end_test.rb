require_relative '../test_helper'

require_relative '../../lib/tyrano_dsl/main'
require_relative '../../lib/tyrano_dsl/vocabulary'
require_relative '../../lib/tyrano_dsl/tyrano_exception'

class EndToEndTest < Minitest::Test

  def run_on_file(file_path)
    TyranoDsl::Main.new.run(
        File.absolute_path(file_path, __dir__)
    )
  end

  def full_path(file_path)
    File.absolute_path(file_path, __dir__)
  end

  def validate_exception(file_path, exception_message)
    begin
      run_on_file(file_path)
    rescue ::TyranoDsl::TyranoException => e
      assert_equal(e.message, exception_message)
    end
  end

  def test_end_to_end
    writing_context = run_on_file('end_to_end_scene.rb')
    assert_equal(writing_context.file_actions.length, 18)

    clear_directories = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::ClearDirectory)
    assert_equal(clear_directories.length, 2)
    directories_to_clean = clear_directories.collect {|d| d.path}
    assert directories_to_clean.include? 'data/bgimage'
    assert directories_to_clean.include? 'data/fgimage/chara'

    file_copies = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::FileCopy)
    assert_equal(file_copies.length, 5)
    files_copies = {}
    file_copies.each do |file_copy_action|
      files_copies[file_copy_action.to_path] = file_copy_action.from_path
    end
    assert_equal(files_copies['data/fgimage/chara/1/0.jpg'], full_path('../assets/characters/shinji/default_stance.jpg'))
    assert_equal(files_copies['data/fgimage/chara/1/1.png'], full_path('../assets/characters/shinji/angry.png'))
    assert_equal(files_copies['data/bgimage/1.jpg'], full_path('../assets/backgrounds/school.jpg'))
    assert_equal(files_copies['data/bgimage/2.jpg'], full_path('subdirectory/alice.jpg'))
    assert_equal(files_copies['data/bgimage/3.jpg'], full_path('../assets/backgrounds/school.jpg'))


    create_files = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::CreateFile)
    assert_equal(create_files.length, 9)
    files_creations = {}
    create_files.each do |create_file_action|
      files_creations[create_file_action.path] = create_file_action.content
    end

    assert_equal(files_creations['data/scenario/system/chara_define.ks'], '[chara_new name="Shinji" jname="Shinji" storage="chara/1/0.jpg"]

[iscript]
f[\'variable_1\']=25;
[endscript]
')

    assert_equal(files_creations['data/scenario/scene1.ks'], '[_tb_system_call storage=system/_scene1.ks]
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

[chara_mod name="Shinji" cross="true" storage="1/1.png"]
[tb_hide_message_window]
[glink color="black" storage="scene2" target="" size="20" x="200" y="200" text="Yes !"]
[glink color="black" storage="scene3" target="label_1" size="20" x="200" y="300" text="No &quot;&quot;?"]
[s]

[chara_hide name="Shinji" time="1000" wait="true"]
[jump storage="scene2.ks" target=""]
')
    assert_equal(files_creations['data/scenario/system/_scene1.ks'], '[preload storage="./data/bgimage/1.jpg"]
[preload storage="./data/fgimage/chara/1/0.jpg"]
[preload storage="./data/fgimage/chara/1/1.png"]
[return]')

    assert_equal(files_creations['data/scenario/title_screen.ks'], '[_tb_system_call storage=system/_title_screen.ks]

[hidemenubutton]

[tb_keyconfig  flag="0"  ]
[tb_hide_message_window  ]
[bg  storage="1.jpg"  ]
*title

[glink  text="New&nbsp;Game"  x="600"  y="370"  target="*start"  ]
[glink  text="Load&nbsp;Game"  x="600"  y="470"  target="*load"  ]
[s  ]
*start

[showmenubutton]

[cm  ]
[tb_keyconfig  flag="1"  ]
[jump  storage="scene1.ks"  target=""  ]
[s  ]
*load

[cm  ]
[showload]

[jump  target="*title"  storage=""  ]
[s  ]
')

    assert_equal(files_creations['data/scenario/system/_title_screen.ks'], '[preload storage="./data/bgimage/1.jpg"]
[return]')

    assert_equal(files_creations['data/scenario/scene2.ks'], '[_tb_system_call storage=system/_scene2.ks]
[cm]
[bg storage="1.jpg" time="1000"]
')
    assert_equal(files_creations['data/scenario/system/_scene2.ks'], '[preload storage="./data/bgimage/1.jpg"]
[return]')

    assert_equal(files_creations['data/scenario/scene3.ks'], '[_tb_system_call storage=system/_scene3.ks]
[cm]
[bg storage="1.jpg" time="1000"]
*label_1
[jump storage="scene3.ks" target="" cond="f.variable_1<10"]
[tb_eval  exp="f.variable_1+=20"  name="variable_1"  cmd="+="  op="t"  val="20"  val_2="undefined"]
[tb_start_text mode=1]
Hello from included scene!
[_tb_end_text]

[bg storage="2.jpg" time="1000"]
')
    assert_equal(files_creations['data/scenario/system/_scene3.ks'], '[preload storage="./data/bgimage/1.jpg"]
[preload storage="./data/bgimage/2.jpg"]
[return]')

    json_patches = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::JsonPatch)
    assert_equal(json_patches.length, 2)
    assert_equal(json_patches[0].file_path, 'builder_config.json')
    assert_equal(json_patches[0].patching_path, ['map_chara'])
    assert_equal(json_patches[0].patched_content, {"Shinji" => 1})
    assert_equal(json_patches[1].file_path, 'builder_config.json')
    assert_equal(json_patches[1].patching_path, ['map_var'])
    assert_equal(json_patches[1].patched_content,
                 {
                     'variable_1' =>
                         {:val => 25, :kind => 'f'}
                 }
    )
  end

  private

  def extract_by_class(array, class_to_be_found)
    array.select do |i|
      i.class == class_to_be_found
    end
  end

end