require 'logger'

require_relative '../tyrano_dsl'
require_relative '../vocabulary'

# Write the content that have been parsed
class TyranoDsl::ExportText::Writer

  def initialize
  end

  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array<String>]
  # @raise [TyranoDsl::TyranoException]
  def write(parsed_words)
    result = []
    parsed_words.each do |parsed_word|
      word_result = write_word(parsed_word)
      if word_result
        result.concat(word_result)
      end
    end
    result
  end

  # @param [TyranoDsl::ParsedWord] parsed_word
  # @return [Array<String>]
  def write_word(parsed_word)
    parameters = parsed_word.parameters
    case parsed_word.word
      when TyranoDsl::Vocabulary::DISPLAY_TEXT
        content = []
        if parameters[:character_name]
          content << "#{parameters[:character_name]}\n"
        end
        content << "#{parameters[:text]}\n"
        content
      when TyranoDsl::Vocabulary::ASK_QUESTION
        parameters[:possible_answers].collect do |possible_answer|
          "#{possible_answer[:text]}\n"
        end
      else
        nil
    end
  end


end