require_relative '../../../../lib/tyrano_dsl/export_tyrano/writing_context'
require_relative '../../unit_test_helper'

module EGWritingWordsHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Elements::World]
  def create_world
    TyranoDsl::Elements::World.new
  end

  # @return [TyranoDsl::ExportTyrano::WritingContext]
  # @param [TyranoDsl::Elements::World] world
  def create_writing_context(world)
    TyranoDsl::ExportTyrano::WritingContext.new(world)
  end

end
