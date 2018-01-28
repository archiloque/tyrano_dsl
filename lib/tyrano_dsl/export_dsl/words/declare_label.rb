require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::DeclareLabel < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word()
    TyranoDsl::Vocabulary::DECLARE_LABEL
  end

  def call_parameters()
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :label_name,
            String
        )
    ]
  end

end