module TyranoDsl
  module Validation

  end
end

class TyranoDsl::Validation::Validator

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def run(world, parsed_words)
    current_scene = nil

    parsed_words.each do |parsed_word|
      parameters = parsed_word.parameters
      case parsed_word.word
        when TyranoDsl::Vocabulary::START_SCENE
          current_scene = world.scenes[parameters[:name]]
        when TyranoDsl::Vocabulary::DECLARE_LABEL
          unless current_scene
            raise_exception 'This action should take place in a scene', parsed_word
          end
          label_name = parameters[:label_name]
          if current_scene.labels.include? label_name
            raise_exception "Duplicated label [#{label_name}]", parsed_word
          end
          current_scene.labels << label_name
        else
          # Don't care
      end
    end
    world.validate
  end

  private

  # @param [String] message
  # @param [TyranoDsl::ParsedWord] parsed_word
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def raise_exception(message, parsed_word)
    exception = TyranoDsl::TyranoException.new(message)
    exception.set_backtrace parsed_word.word_location
    raise exception
  end

end