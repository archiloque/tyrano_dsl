module TyranoDsl::ImportDsl::Words::SetTitleScreenBackground

  # @param [String] background_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_title_screen_background(background_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_TITLE_SCREEN_BACKGROUND,
        background_name: background_name
    )
  end

end
