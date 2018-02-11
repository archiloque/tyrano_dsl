module TyranoDsl::ImportDsl::Words::ClearMessages

  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def clear_messages
    add_parsed_word(
        TyranoDsl::Vocabulary::CLEAR_MESSAGES,
        )
  end

end
