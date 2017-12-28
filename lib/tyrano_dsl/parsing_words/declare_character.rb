require_relative '../elements/character'

module TyranoDsl::ParsingWords::DeclareCharacter

  # @param [String] character_name
  # @param [Hash{String => String}] stances
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_character(character_name, stances)
    symbolized_stances = symbolize_keys(stances)
    symbolized_stances.each_pair do |name, path|
      symbolized_stances[name] = file_full_path(path)
    end

    default_stance = symbolized_stances[:default]
    unless default_stance
      raise TyranoDsl::TyranoException, 'A default stance is required'
    end
    if context.world.characters.key? character_name
      raise TyranoDsl::TyranoException, "Duplicated character [#{character_name}]"
    end
    context.world.characters[character_name] = TyranoDsl::Elements::Character.new(
        character_name,
        symbolized_stances,
        context.world.characters.length + 1
    )

    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_CHARACTER,
        name: character_name, stances: symbolized_stances, default_stance: default_stance
    )
  end

end
