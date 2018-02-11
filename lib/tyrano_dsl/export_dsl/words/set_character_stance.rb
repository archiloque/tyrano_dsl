require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::SetCharacterStance < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::SET_CHARACTER_STANCE
  end

  def call_parameters
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
            :duration,
            Integer,
            false,
            600
        )
    ]
  end

end