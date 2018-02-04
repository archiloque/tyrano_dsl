module TyranoDsl::ImportDsl::Words::DisplayText

  # @param [String, nil] character_name
  # @param [String] text
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def display_text(character_name, text)
    add_parsed_word(
        TyranoDsl::Vocabulary::DISPLAY_TEXT,
        character_name: character_name,
        text: text,
        )
  end

end
