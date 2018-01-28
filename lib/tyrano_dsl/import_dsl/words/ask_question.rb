module TyranoDsl::ImportDsl::Words::AskQuestion

  # @param [Array<Hash{String=>Object}>] possible_answers
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def ask_question(possible_answers)
    symbolized_possible_answers = possible_answers.collect do |possible_answer|
      symbolize_keys(possible_answer)
    end

    add_parsed_word(
        TyranoDsl::Vocabulary::ASK_QUESTION,
        possible_answers: symbolized_possible_answers
    )
  end

end
