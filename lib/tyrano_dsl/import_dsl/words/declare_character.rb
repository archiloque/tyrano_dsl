require_relative '../../elements/character'

module TyranoDsl::ImportDsl::Words::DeclareCharacter

  # @param [String] character_name
  # @param [Hash{String => String}] stances
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_character(character_name, stances)
    symbolized_stances = symbolize_keys(stances)
    symbolized_stances.each_pair do |name, path|
      symbolized_stances[name] = file_full_path(path)
    end
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_CHARACTER,
        character_name: character_name,
        stances: symbolized_stances,
        )
  end

end
