require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::ClearMessages < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::CLEAR_MESSAGES
  end

  def call_parameters
    []
  end

end
