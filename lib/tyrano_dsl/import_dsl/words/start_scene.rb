require_relative '../../elements/scene'

module TyranoDsl::ImportDsl::Words::StartScene

  # @param [String] scene_name
  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def start_scene(scene_name)
    add_parsed_word(
        TyranoDsl::Vocabulary::START_SCENE,
        scene_name: scene_name
    )
  end

end
