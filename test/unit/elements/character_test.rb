require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/character'

class CharacterTest < Minitest::Test

  def test_character
    character = TyranoDsl::Elements::Character.new(
        'Shinji',
        {
            'default' => 'stance/default.png',
            'angry' => 'stance/angry.jpg',
        },
        20)
    assert_equal(character.name, 'Shinji')
    assert_equal(character.index, 20)
    assert_equal(character.stances.length, 2)

    stance1 = character.stances['default']
    assert_equal(stance1.name, 'default')
    assert_equal(stance1.original_file_name, 'stance/default.png')
    assert_equal(stance1.short_target_file_name, '20/0.png')
    assert_equal(stance1.long_target_file_name, 'data/fgimage/chara/20/0.png')

    stance2 = character.stances['angry']
    assert_equal(stance2.name, 'angry')
    assert_equal(stance2.original_file_name, 'stance/angry.jpg')
    assert_equal(stance2.short_target_file_name, '20/1.jpg')
    assert_equal(stance2.long_target_file_name, 'data/fgimage/chara/20/1.jpg')
  end

end