require_relative '../elements/background'
require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::DeclareLabel

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def declare_label(label_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        label_name: label_name
    )
    context.world.label_value(label_name)
  end

end
