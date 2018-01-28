require_relative 'end_to_end_base_test'

class EndToEndTest::ImportDslExportTyranoTest < EndToEndTest::BaseTest

  def read_file(path)
    IO.read(File.join(__dir__, 'dsl_to_tyrano', path))
  end

  def test_end_to_end
    file_actions = run_on_file('end_to_end_scene.rb', 'dsl', 'tyrano')
    assert_equal(18, file_actions.length)

    clear_directories = extract_by_class(file_actions, TyranoDsl::FileActions::ClearDirectory)
    assert_equal(2, clear_directories.length)
    directories_to_clean = clear_directories.collect {|d| d.path}
    assert directories_to_clean.include? 'data/bgimage'
    assert directories_to_clean.include? 'data/fgimage/chara'

    file_copies = extract_by_class(file_actions, TyranoDsl::FileActions::FileCopy)
    assert_equal(5, file_copies.length)
    files_copies = {}
    file_copies.each do |file_copy_action|
      files_copies[file_copy_action.to_path] = file_copy_action.from_path
    end
    assert_equal(full_path('../assets/characters/shinji/default_stance.jpg'), files_copies['data/fgimage/chara/1/0.jpg'])
    assert_equal(full_path('../assets/characters/shinji/angry.png'), files_copies['data/fgimage/chara/1/1.png'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), files_copies['data/bgimage/1.jpg'])
    assert_equal(full_path('subdirectory/alice.jpg'), files_copies['data/bgimage/2.jpg'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), files_copies['data/bgimage/3.jpg'])

    create_files = extract_by_class(file_actions, TyranoDsl::FileActions::CreateFile)
    assert_equal(create_files.length, 9)

    create_files.each do |create_file_action|
      assert_equal(
          read_file(create_file_action.path.gsub('/', '#')),
          create_file_action.content
      )
    end

    json_patches = extract_by_class(file_actions, TyranoDsl::FileActions::JsonPatch)
    assert_equal(2, json_patches.length)
    assert_equal('builder_config.json', json_patches[0].file_path)
    assert_equal(['map_chara'], json_patches[0].patching_path)
    assert_equal({"Shinji" => 1}, json_patches[0].patched_content)
    assert_equal('builder_config.json', json_patches[1].file_path)
    assert_equal(['map_var'], json_patches[1].patching_path)
    assert_equal(
        {
            'variable_1' =>
                {:val => 25, :kind => 'f'}
        },
        json_patches[1].patched_content
    )
  end

end