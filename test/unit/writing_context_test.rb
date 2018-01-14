require_relative '../../lib/tyrano_dsl/export_tyrano/writing_context'
require_relative 'unit_test_helper'

class WritingContextTest < Minitest::Test

  include UnitTestHelper

  def test_duplicated_label
    world = TyranoDsl::Elements::World.new
    writing_context = TyranoDsl::ExportTyrano::WritingContext.new(world)
    writing_context.init_new_scene 'scene name'
    writing_context.add_label caller, 'label name'
    assert_tyrano_exception('Duplicated label [label name]') do
      writing_context.add_label caller, 'label name'
    end
  end
end