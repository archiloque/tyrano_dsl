require_relative 'export_text'

class TyranoDsl::ExportText::Main

  # @param [TyranoDsl::Elements::World] _world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array<String>]
  def run(_world, parsed_words)
    result = []
    parsed_words.each do |parsed_word|
      result.concat(write_word(parsed_word))
    end
    result
  end

  # @param [Array<String>] content
  # @param [String] _export_path
  # @return [void]
  def apply(content, _export_path)
    STDOUT << "\n\nGame content :\n"
    content.each do |entry|
      STDOUT << entry
    end
  end

  private

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
          "  #{possible_answer[:text]}\n"
        end
      else
        []
    end
  end

end