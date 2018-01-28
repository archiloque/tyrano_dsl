require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::Jump < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::JUMP
  end

  def call_parameters()
    [
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