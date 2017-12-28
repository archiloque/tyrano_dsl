require_relative '../elements/jump_target'
module TyranoDsl::ParsingWords::Jump

  # @param [String] scene_name
  # @param [String, nil] label_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def jump(scene_name, label_name = nil)
    add_parsed_word(
        TyranoDsl::Vocabulary::JUMP,
        scene_name: scene_name,
        label_name: label_name
    )
    label = label_name ? context.world.label_value(label_name) : nil
    context.world.jump_targets << TyranoDsl::Elements::JumpTarget.new(scene_name, label)
  end
end
