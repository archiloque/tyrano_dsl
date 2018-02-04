require_relative 'end_to_end_base_test'

class EndToEndTest::ImportDslExportTyranoTest < EndToEndTest::BaseTest

  def test_end_to_end
    file_actions = run_on_file('dsl', 'tyrano', 'end_to_end_scene.rb')
    assert_equal(18, file_actions.length)

    clear_directories = extract_by_class(file_actions, TyranoDsl::FileActions::ClearDirectory)
    assert_equal(2, clear_directories.length)
    directories_to_clean = clear_directories.collect {|d| d.path}
    assert_includes directories_to_clean, 'data/bgimage'
    assert_includes directories_to_clean, 'data/fgimage/chara'

    file_copies = create_file_copies_hash(file_actions)
    assert_equal(5, file_copies.length)
    assert_equal(full_path('../assets/characters/shinji/default_stance.jpg'), file_copies['data/fgimage/chara/1/0.jpg'])
    assert_equal(full_path('../assets/characters/shinji/angry.png'), file_copies['data/fgimage/chara/1/1.png'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), file_copies['data/bgimage/1.jpg'])
    assert_equal(full_path('subdirectory/alice.jpg'), file_copies['data/bgimage/2.jpg'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), file_copies['data/bgimage/3.jpg'])

    check_files_contents('dsl_to_tyrano', file_actions, 9)

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