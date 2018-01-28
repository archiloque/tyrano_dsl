require_relative '../../../lib/tyrano_dsl/export_tyrano/context'
require_relative '../unit_test_helper'

module ETHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Elements::World]
  def create_world
    TyranoDsl::Elements::World.new
  end

  # @return [TyranoDsl::ExportTyrano::Context]
  # @param [TyranoDsl::Elements::World] world
  def create_context(world)
    TyranoDsl::ExportTyrano::Context.new(world)
  end

end
