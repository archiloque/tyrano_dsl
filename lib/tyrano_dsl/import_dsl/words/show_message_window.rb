module TyranoDsl::ImportDsl::Words::ShowMessageWindow

  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def show_message_window
    add_parsed_word(
        TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW,
        )
  end

end
