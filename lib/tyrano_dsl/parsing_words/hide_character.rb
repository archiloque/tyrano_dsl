module TyranoDsl::ParsingWords::HideCharacter

  # @param [String] character_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def hide_character(character_name)
    check_character_exist(character_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::HIDE_CHARACTER,
        name: character_name
    )
  end

end
