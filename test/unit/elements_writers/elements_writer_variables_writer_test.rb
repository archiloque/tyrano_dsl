require_relative '../unit_test_helper'
require_relative '../../../lib/tyrano_dsl/elements/world'
require_relative '../../../lib/tyrano_dsl/elements_writers/variables_writer'

class ElementsWriterVariablesWriterTest < Minitest::Test

  include UnitTestHelper

  def test_ok
    world = TyranoDsl::Elements::World.new('game.rb')
    variables_writer = TyranoDsl::ElementsWriters::VariablesWriter.new
    declare_variable(world, 'variable 1', 10)
    file_actions = variables_writer.write(world)
    assert_equal(file_actions.length, 1)
    assert_equal(file_actions[0].file_path, 'builder_config.json')
    assert_equal(file_actions[0].patching_path, ['map_var'])
    assert_equal(file_actions[0].patched_content, 'variable_1' => {:val => 10, :kind => 'f'})
  end

end
