require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::ShowMessageWindow < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::SHOW_MESSAGE_WINDOW
  end

  def call_parameters()
    []
  end

end