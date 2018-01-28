require_relative 'empty_word'

class TyranoDsl::Validation::Words::DeclareLabel < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :label_name
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    label_name = parameters[:label_name]
    if context.current_scene.labels.include?(label_name)
      TyranoDsl::TyranoException.raise_exception "Duplicated label [#{label_name}]", word_location
    end
    context.current_scene.labels << label_name
  end

end