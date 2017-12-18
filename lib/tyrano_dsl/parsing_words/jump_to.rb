require_relative '../elements/jump_target'
require_relative '../vocabulary'
require_relative 'parsing_words_module'

module TyranoDsl::ParsingWords::JumpTo

  include TyranoDsl::ParsingWords::ParsingWordsModule

  # @param [String] scene_name
  # @param [String, nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def jump_to(scene_name, label_name = nil)
    add_parsed_word(
        TyranoDsl::Vocabulary::JUMP_TO,
        scene_name: scene_name,
        label_name: label_name
    )
    label = label_name ? context.world.label_value(label_name) : nil
    context.world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label)
  end
end
