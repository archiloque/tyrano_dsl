require_relative '../../../lib/tyrano_dsl/writing_context'
require_relative '../unit_test_helper'

module WritingWordsHelper

  include UnitTestHelper

  protected

  # @return [TyranoDsl::Elements::World]
  def create_world
    TyranoDsl::Elements::World.new(__FILE__)
  end

  # @return [TyranoDsl::WritingContext]
  # @param [TyranoDsl::Elements::World] world
  def create_writing_context(world)
    TyranoDsl::WritingContext.new(world)
  end

end
