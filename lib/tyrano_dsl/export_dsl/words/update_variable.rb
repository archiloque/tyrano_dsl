require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::UpdateVariable < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::UPDATE_VARIABLE
  end

  def call_parameters
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :variable,
            String
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :operator,
            String
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :value,
            [String, Float]
        )
    ]
  end

end