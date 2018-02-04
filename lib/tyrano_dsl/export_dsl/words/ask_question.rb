require_relative 'plain_writing_word'

class TyranoDsl::ExportDsl::Words::AskQuestion < TyranoDsl::ExportDsl::Words::PlainWritingWord

  def word
    TyranoDsl::Vocabulary::ASK_QUESTION
  end

  def call_parameters
    [
        TyranoDsl::ExportDsl::Words::CallParameter.new(
            :possible_answers,
            Array
        )
    ]
  end

end