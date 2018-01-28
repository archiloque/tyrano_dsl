require_relative '../et_helper'
require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_tyrano/elements_writers/variables_writer'
require_relative '../et_helper'

class ETElementsWriterVariablesWriterTest < Minitest::Test

  include ETHelper

  def test_ok
    world = TyranoDsl::Elements::World.new
    context = create_context(world)
    variables_writer = TyranoDsl::ExportTyrano::ElementsWriters::VariablesWriter.new
    declare_variable(world, 'variable 1', 10)
    file_actions = variables_writer.write(context, world)
    assert_equal(1, file_actions.length)
    assert_equal('builder_config.json', file_actions[0].file_path)
    assert_equal(['map_var'], file_actions[0].patching_path)
    assert_equal({'variable_1' => {:val => 10, :kind => 'f'}}, file_actions[0].patched_content)
  end

end
