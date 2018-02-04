require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::HideMessageWindow < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::HIDE_MESSAGE_WINDOW
  end

  def call_parameters
    []
  end

end