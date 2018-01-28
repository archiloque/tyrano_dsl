module TyranoDsl::ImportDsl::Words::SetBackground

  # @param [String] background_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def set_background(background_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::SET_BACKGROUND,
        background_name: background_name
    )
  end

end
