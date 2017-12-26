require_relative '../unit_test_helper'
require_relative '../../../lib/tyrano_dsl/elements/world'
require_relative '../../../lib/tyrano_dsl/elements_writers/characters_writer'

class ElementsWriterCharactersWriterTest < Minitest::Test

  include UnitTestHelper

  def test_ok
    world = TyranoDsl::Elements::World.new
    characters_writer = TyranoDsl::ElementsWriters::CharactersWriter.new
    declare_character(
        world,
        'Character 1', :default => '../../assets/characters/shinji/default_stance.jpg',
        :angry => '../../assets/characters/shinji/angry.png'
    )
    declare_variable(world, 'variable 1', 10)
    file_actions = characters_writer.write(world)
    assert_equal(file_actions.length, 2)
    assert_equal(file_actions[0].path, 'data/scenario/system/chara_define.ks')
    assert_equal(file_actions[0].content, '[chara_new name="Character 1" jname="Character 1" storage="chara/1/0.jpg"]

[iscript]
f[\'variable_1\']=10;
[endscript]
')
    assert_equal(file_actions[1].file_path, 'builder_config.json')
    assert_equal(file_actions[1].patching_path, ['map_chara'])
    assert_equal(file_actions[1].patched_content, 'Character 1' => 1)
  end

end
