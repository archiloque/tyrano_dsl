require_relative 'end_to_end_base_test'

class EndToEndTest::ImportDslExportDslTest < EndToEndTest::BaseTest

  def read_file(path)
    IO.read(File.join(__dir__, 'dsl_to_dsl', path))
  end

  def test_end_to_end
    file_actions = run_on_file('end_to_end_scene.rb', 'dsl', 'dsl')
    assert_equal(9, file_actions.length)

    file_copies = extract_by_class(file_actions, TyranoDsl::FileActions::FileCopy)
    assert_equal(5, file_copies.length)
    files_copies = {}
    file_copies.each do |file_copy_action|
      files_copies[file_copy_action.to_path] = file_copy_action.from_path
    end
    assert_equal(full_path("../assets/characters/shinji/default_stance.jpg"), files_copies["characters/shinji/default.jpg"])
    assert_equal(full_path('../assets/characters/shinji/angry.png'), files_copies['characters/shinji/angry.png'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), files_copies['backgrounds/school.jpg'])
    assert_equal(full_path('subdirectory/alice.jpg'), files_copies['backgrounds/alice.jpg'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), files_copies['backgrounds/same_school.jpg'])

    create_files = extract_by_class(file_actions, TyranoDsl::FileActions::CreateFile)
    assert_equal(create_files.length, 4)
    create_files.each do |create_file_action|
      assert_equal(
          read_file(create_file_action.path.gsub('/', '#')),
          create_file_action.content
      )
    end


  end

end