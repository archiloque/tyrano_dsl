require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/writers/characters'
require_relative 'writers_base_test'

class ExportTyranoWriters::CharactersTest < ExportTyranoWriters::WritersBaseTest

  def test_ok
    world = create_world
    context = create_context(world)
    characters_writer = TyranoDsl::ExportTyrano::Writers::Characters.new
    declare_character(
        world,
        'Character 1', :default => '../../assets/characters/shinji/default_stance.jpg',
        :angry => '../../assets/characters/shinji/angry.png'
    )
    declare_variable(world, 'variable 1', 10)
    declare_variable(world, 'variable 2', 'yolo')
    declare_variable(world, 'variable 3')
    context.after_setup
    file_actions = characters_writer.write(context, world)
    assert_equal(2, file_actions.length)
    assert_equal('data/scenario/system/chara_define.ks', file_actions[0].path)
    assert_equal('[chara_new name="Character 1" jname="Character 1" storage="chara/1/0.jpg"]

[iscript]
f[\'variable_1\']=10;
f[\'variable_2\']="yolo";
f[\'variable_3\']=\'\';
[endscript]
', file_actions[0].content)
    assert_equal('builder_config.json', file_actions[1].file_path)
    assert_equal(['map_chara'], file_actions[1].patching_path)
    assert_equal({'Character 1' => 1}, file_actions[1].patched_content)
  end

end
