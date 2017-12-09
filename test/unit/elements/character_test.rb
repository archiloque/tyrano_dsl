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
        20 )
    assert_equal character.name, 'Shinji'
    assert_equal character.index, 20
    assert_equal character.stances, {
        'default' => 'stance/default.png',
        'angry' => 'stance/angry.jpg',
    }
    assert_equal character.default_stance_target_short_file_name, '20/0.png'
    assert_equal character.stances_target_long_files_names, {
        'default'=>'data/fgimage/chara/20/0.png',
        'angry'=>'data/fgimage/chara/20/1.jpg'
    }

  end
end