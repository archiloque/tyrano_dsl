module TyranoDsl::ParsingWords::HideMessageWindow

  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def hide_message_window
    add_parsed_word(
        TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW,
        )
  end

end
