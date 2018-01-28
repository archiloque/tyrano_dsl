require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::ConditionalJump < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::CONDITIONAL_JUMP
  end

  def call_parameters()
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
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :scene_name,
            String
        ),
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :label_name,
            String,
            false
        )
    ]
  end

end