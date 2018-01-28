require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::SetBackground < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::SET_BACKGROUND
  end

  def call_parameters()
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :background_name,
            String
        )
    ]
  end

end