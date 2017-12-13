require_relative '../test_helper'
require_relative '../../lib/tyrano_dsl/writing_context'

class WritingContextTest < Minitest::Test

  def test_duplicated_label
    world = TyranoDsl::Elements::World.new(__FILE__)
    writing_context = TyranoDsl::WritingContext.new(world)
    writing_context.init_new_scene 'scene name'
    writing_context.add_label caller_locations, 'label name'
    begin
      writing_context.add_label caller_locations, 'label name'
      fail
    rescue TyranoDsl::TyranoException => e
      assert_match /Line \d+ duplicated label \[label name\]/, e.message
    end
  end
end