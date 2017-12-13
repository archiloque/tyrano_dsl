require_relative '../test_helper'

require_relative '../../lib/tyrano_dsl/main'
require_relative '../../lib/tyrano_dsl/vocabulary'
require_relative '../../lib/tyrano_dsl/tyrano_exception'

class EndToEndTest < Minitest::Test

  def run_on_file(file_path)
    TyranoDsl::Main.new.run(File.join(__dir__, file_path))
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
    assert_equal writing_context.file_actions.length, 13

    clear_directories = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::ClearDirectory)
    assert_equal clear_directories.length, 2
    directories_to_clean = clear_directories.collect {|d| d.path}
    assert directories_to_clean.include? 'data/bgimage'
    assert directories_to_clean.include? 'data/fgimage/chara'

    file_copies = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::FileCopy)
    assert_equal file_copies.length, 3
    files_copies = {}
    file_copies.each do |file_copy_action|
      files_copies[file_copy_action.to_path] = file_copy_action.from_path
    end
    assert_equal files_copies['data/fgimage/chara/1/0.jpg'], '../assets/characters/shinji/default_stance.jpg'
    assert_equal files_copies['data/fgimage/chara/1/1.png'], '../assets/characters/shinji/angry.png'
    assert_equal files_copies['data/bgimage/1.jpg'], '../assets/backgrounds/school.jpg'

    create_files = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::CreateFile)
    assert_equal create_files.length, 7
    files_creations = {}
    create_files.each do |create_file_action|
      files_creations[create_file_action.path] = create_file_action.content
    end

    assert_equal files_creations['data/scenario/system/chara_define.ks'], '[chara_new name="Shinji" jname="Shinji" storage="chara/1/0.jpg"]
[iscript]
[endscript]
'

    assert_equal files_creations['data/scenario/scene1.ks'], '[_tb_system_call storage=system/_scene1.ks]
[bg storage="1.jpg" time="1000"]
*Label 1
[chara_show name="Shinji" time="1000" wait="true" left="434" top="128" width="" height="" reflect="false"]
[tb_start_text mode=1 ]
#Shinji
Hello!
[_tb_end_text]

[chara_hide name="Shinji" time="1000" wait="true"]
[jump storage="scene2.ks" target=""]
'
    assert_equal files_creations['data/scenario/system/_scene1.ks'], '[preload storage="./data/bgimage/1.jpg"]
[preload storage="./data/fgimage/chara/1/0.jpg"]
[preload storage="./data/fgimage/chara/1/1.png"]
[return]'

    assert_equal files_creations['data/scenario/title_screen.ks'], '[_tb_system_call storage=system/_title_screen.ks]

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
'

    assert_equal files_creations['data/scenario/system/_title_screen.ks'], '[preload storage="./data/bgimage/1.jpg"]
[return]'

    assert_equal files_creations['data/scenario/scene2.ks'], '[_tb_system_call storage=system/_scene2.ks]
[bg storage="1.jpg" time="1000"]
'
    assert_equal files_creations['data/scenario/system/_scene2.ks'], '[preload storage="./data/bgimage/1.jpg"]
[return]'


    json_patches = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::JsonPatch)
    assert_equal json_patches.length, 1
    assert_equal json_patches[0].file_path, 'builder_config.json'
    assert_equal json_patches[0].patching_path, ['map_chara']
    assert_equal json_patches[0].patched_content, {"Shinji"=>1}

  end

  private

  def extract_by_class(array, class_to_be_found)
    array.select do |i|
      i.class == class_to_be_found
    end
  end

end