require 'simplecov'
SimpleCov.start

require 'pathname'
require 'minitest/autorun'
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

  def test_missing_file
    validate_exception(
        'missing_file.rb',
        'Line 1 missing file [missing_file.png]'
    )
  end

  def test_simple_scene
    writing_context = run_on_file('simple_scene.rb')
    assert_equal writing_context.file_actions.length, 10

    clear_directory_actions = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::ClearDirectory)
    assert_equal clear_directory_actions.length, 2
    directories_to_clean = clear_directory_actions.collect {|d| d.path}
    assert directories_to_clean.include? 'bgimage'
    assert directories_to_clean.include? 'fgimage'

    file_copy_actions = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::FileCopyAction)
    assert_equal file_copy_actions.length, 3
    files_copies = {}
    file_copy_actions.each do |file_copy_action|
      files_copies[file_copy_action.to_path] = file_copy_action.from_path
    end
    assert_equal files_copies['fgimage/1/0.jpg'], 'characters/shinji/default_stance.jpg'
    assert_equal files_copies['fgimage/1/1.png'], 'characters/shinji/angry.png'
    assert_equal files_copies['bgimage/1.jpg'], 'backgrounds/school.jpg'

    create_file_actions = extract_by_class(writing_context.file_actions, TyranoDsl::FileActions::CreateFileAction)
    assert_equal create_file_actions.length, 5
    files_creations = {}
    create_file_actions.each do |create_file_action|
      files_creations[create_file_action.path] = create_file_action.content
    end

    assert_equal files_creations['system/chara_define.ks'], '[chara_new name="Shinji" jname="Shinji" storage="fgimage/1/0.jpg"]
[iscript]
[endscript]
'

    assert_equal files_creations['scene1.ks'], '[_tb_system_call storage=system/_scene1.ks]
[bg storage="1.jpg" time="1000"]
[chara_show name="Shinji" time="1000" wait="true" left="434" top="128" width="" height="" reflect="false"]
[tb_start_text mode=1 ]
#Shinji
Hello!
[_tb_end_text]

[jump storage="scene2.ks" target=""]
'
    assert_equal files_creations['system/_scene1.ks'], '[preload storage="./data/bgimage/1.jpg"]
[preload storage="./data/fgimage/1/0.jpg"]
[preload storage="./data/fgimage/1/1.png"]
[return]'

    assert_equal files_creations['scene2.ks'], '[_tb_system_call storage=system/_scene2.ks]

'
    assert_equal files_creations['system/_scene2.ks'], '[return]'


    p writing_context.world.inspect
  end

  private

  def extract_by_class(array, class_to_be_found)
    array.select do |i|
      i.class == class_to_be_found
    end
  end

end