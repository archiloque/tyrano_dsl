require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::DisplayText < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::DISPLAY_TEXT
  end

  def call_parameters()
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :character_name,
            String
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :text,
            String
        )
    ]
  end

end