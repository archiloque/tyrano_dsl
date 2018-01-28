module TyranoDsl::ImportDsl::Words::HideCharacter

  # @param [String] character_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def hide_character(character_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::HIDE_CHARACTER,
        character_name: character_name
    )
  end

end
