require_relative 'end_to_end_base_test'

class EndToEndTest::ImportDslExportDslTest < EndToEndTest::BaseTest

  def test_end_to_end
    file_actions = run_on_file('dsl', 'dsl', 'end_to_end_scene.rb')
    assert_equal(9, file_actions.length)

    file_copies = create_file_copies_hash(file_actions)
    assert_equal(5, file_copies.length)
    assert_equal(full_path("../assets/characters/shinji/default_stance.jpg"), file_copies["characters/shinji/default.jpg"])
    assert_equal(full_path('../assets/characters/shinji/angry.png'), file_copies['characters/shinji/angry.png'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), file_copies['backgrounds/school.jpg'])
    assert_equal(full_path('subdirectory/alice.jpg'), file_copies['backgrounds/alice.jpg'])
    assert_equal(full_path('../assets/backgrounds/school.jpg'), file_copies['backgrounds/same_school.jpg'])

    check_files_contents('dsl_to_dsl', file_actions, 4)
  end

end