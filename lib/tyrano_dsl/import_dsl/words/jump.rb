module TyranoDsl::ImportDsl::Words::Jump

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
  end
end
