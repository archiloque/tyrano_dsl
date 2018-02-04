require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/writers/variables'
require_relative 'writers_base_test'

class ExportTyranoWriters::VariablesWriterTest < ExportTyranoWriters::WritersBaseTest

  include ETHelper

  def test_ok
    world = TyranoDsl::Elements::World.new
    context = create_context(world)
    variables_writer = TyranoDsl::ExportTyrano::Writers::Variables.new
    declare_variable(world, 'variable 1', 10)
    declare_variable(world, 'variable 2', 'yolo')
    declare_variable(world, 'variable 3')
    file_actions = variables_writer.write(context, world)
    assert_equal(1, file_actions.length)
    assert_equal('builder_config.json', file_actions[0].file_path)
    assert_equal(['map_var'], file_actions[0].patching_path)
    assert_equal({
                     'variable_1' => {:val => 10, :kind => 'f'},
                     'variable_2' => {:val => 'yolo', :kind => 'f'},
                     'variable_3' => {:val => '', :kind => 'f'}
                 }, file_actions[0].patched_content)
  end

end
