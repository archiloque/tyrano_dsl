require_relative '../../test_helper'
require_relative '../../../lib/tyrano_dsl/elements/character'

class ElementsCharacterTest < Minitest::Test

  def test_character
    character = TyranoDsl::Elements::Character.new(
        'Shinji',
        {
            'default' => 'stance/default.png',
            'angry' => 'stance/angry.jpg',
        },
        20)
    assert_equal('Shinji', character.name)
    assert_equal(20, character.index)
    assert_equal(2, character.stances.length)

    stance1 = character.stances['default']
    assert_equal('default', stance1.name)
    assert_equal('stance/default.png', stance1.original_file_name)
    assert_equal('20/0.png', stance1.short_target_file_name)
    assert_equal('data/fgimage/chara/20/0.png', stance1.long_target_file_name)

    stance2 = character.stances['angry']
    assert_equal('angry', stance2.name)
    assert_equal('stance/angry.jpg', stance2.original_file_name)
    assert_equal('20/1.jpg', stance2.short_target_file_name)
    assert_equal('data/fgimage/chara/20/1.jpg', stance2.long_target_file_name)
  end

end