require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::HideCharacter < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::HIDE_CHARACTER
  end

  def call_parameters()
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :character_name,
            String
        )
    ]
  end

end