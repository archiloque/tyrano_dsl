require_relative 'empty_word'

class TyranoDsl::Validation::Words::DeclareBackground < TyranoDsl::Validation::Words::EmptyWord

  # @param [TyranoDsl::Validation::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    background_name = parameters[:background_name]
    if world.backgrounds.key? background_name
      TyranoDsl::TyranoException.raise_exception "Duplicated background [#{background_name}]", word_location
    end

    file_path = parameters[:image_path]
    unless File.exist?(file_path)
      TyranoDsl::TyranoException.raise_exception "Missing file [#{file_path}]", word_location
    end

    world.backgrounds[background_name] =
        TyranoDsl::Elements::Background.new(
            background_name,
            file_path,
            )
  end

end