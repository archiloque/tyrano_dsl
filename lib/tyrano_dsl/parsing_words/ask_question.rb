require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl
  module ParsingWords

    module AskQuestion

      include TyranoDsl::ParsingWords::ParsingWordsModule

      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      # @param [Hash{String=>Hash\nil}] possible_answers
      def ask_question(possible_answers)
        symbolized_possible_answers = possible_answers.collect do |possible_answer|
          unless possible_answer.is_a? Hash
            raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} parameter is invalid"
          end
          symbolized_possible_answer = symbolize_keys(possible_answer)
          [:text, :left, :top, :scene].each do |param_name|
            unless symbolized_possible_answer.key? param_name
              raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} missing value for #{param_name}"
            end
          end
          scene = symbolized_possible_answer[:scene]
          label = symbolized_possible_answer[:label]
          context.world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene, label ? context.world.label_value(label) : nil)
          symbolized_possible_answer
        end
        add_parsed_word(
            TyranoDsl::Vocabulary::ASK_QUESTION,
            possible_answers: symbolized_possible_answers
        )
      end
    end
  end
end
