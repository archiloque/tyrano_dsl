require_relative '../../unit_test_helper'
require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_game/elements_writers/characters_writer'

class EGElementsWriterCharactersWriterTest < Minitest::Test

  include UnitTestHelper

  def test_ok
    world = TyranoDsl::Elements::World.new
    characters_writer = TyranoDsl::ExportGame::ElementsWriters::CharactersWriter.new
    declare_character(
        world,
        'Character 1', :default => '../../assets/characters/shinji/default_stance.jpg',
        :angry => '../../assets/characters/shinji/angry.png'
    )
    declare_variable(world, 'variable 1', 10)
    file_actions = characters_writer.write(world)
    assert_equal(2, file_actions.length)
    assert_equal('data/scenario/system/chara_define.ks', file_actions[0].path)
    assert_equal('[chara_new name="Character 1" jname="Character 1" storage="chara/1/0.jpg"]

[iscript]
f[\'variable_1\']=10;
[endscript]
', file_actions[0].content)
    assert_equal('builder_config.json', file_actions[1].file_path)
    assert_equal(['map_chara'], file_actions[1].patching_path)
    assert_equal({'Character 1' => 1}, file_actions[1].patched_content)
  end

end
