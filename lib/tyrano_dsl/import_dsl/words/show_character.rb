module TyranoDsl::ImportDsl::Words::ShowCharacter

  # @param [String] character_name
  # @param [String] character_stance
  # @param [Integer] left
  # @param [Integer] top
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def show_character(character_name, character_stance, left, top)
    symbolized_stance = symbolize(character_stance)
    add_parsed_word(
        TyranoDsl::Vocabulary::SHOW_CHARACTER,
        character_name: character_name,
        stance: symbolized_stance,
        left: left,
        top: top
    )
  end

end
