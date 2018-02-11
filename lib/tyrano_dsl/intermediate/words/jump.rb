require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::Jump < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @option parameters [String|nil] :label_name
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    world.jump_targets << TyranoDsl::Elements::JumpTarget.new(
        parameters[:scene_name],
        parameters[:label_name],
        word_location)
  end

end