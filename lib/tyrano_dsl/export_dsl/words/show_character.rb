require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::ShowCharacter < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::SHOW_CHARACTER
  end

  def call_parameters()
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :character_name,
            String
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :stance,
            Symbol
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :left,
            Float
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :top,
            Float
        )
    ]
  end

end