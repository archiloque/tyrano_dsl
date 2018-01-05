require_relative '../../../../lib/tyrano_dsl/export_game/writing_context'
require_relative '../../unit_test_helper'

module EGWritingWordsHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Elements::World]
  def create_world
    TyranoDsl::Elements::World.new
  end

  # @return [TyranoDsl::ExportGame::WritingContext]
  # @param [TyranoDsl::Elements::World] world
  def create_writing_context(world)
    TyranoDsl::ExportGame::WritingContext.new(world)
  end

end
