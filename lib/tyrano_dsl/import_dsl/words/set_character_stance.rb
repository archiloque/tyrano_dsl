module TyranoDsl::ImportDsl::Words::SetCharacterStance

  # @param [String] character_name
  # @param [String] character_stance
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_character_stance(character_name, character_stance)
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
        character_name: character_name,
        stance: symbolize(character_stance)
    )
  end

end
