require_relative 'empty_word'

class TyranoDsl::Intermediate::Words::DeclareCharacter < TyranoDsl::Intermediate::Words::EmptyWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Array<String>] word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :character_name
  # @option parameters [Hash{String|Symbol=>String}] :stances
  # @return [void]
  def world_construction_phase(context, world, word_location, parameters)
    character_name = parameters[:character_name]
    if world.characters.key? character_name
      TyranoDsl::TyranoException.raise_exception "Duplicated character [#{character_name}]", word_location
    end
    stances = parameters[:stances]
    unless stances.key? :default
      TyranoDsl::TyranoException.raise_exception 'A default stance is required', word_location
    end

    stances.values.each do |path|
      unless File.exist?(path)
        TyranoDsl::TyranoException.raise_exception "Missing file [#{path}]", word_location
      end
    end

    world.characters[character_name] = TyranoDsl::Elements::Character.new(
        character_name,
        stances
    )
  end

end