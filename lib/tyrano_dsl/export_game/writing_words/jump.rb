require_relative 'writing_words_module'

class TyranoDsl::ExportGame::WritingWords::Jump

  include TyranoDsl::ExportGame::WritingWords::WritingWordsModule

  def run(writing_context, world, word_location, parameters)
    scene_name = parameters[:scene_name]
    label_name = parameters[:label_name]
    target_scene = fetch_scene(world, word_location, scene_name)
    label = label_name ? world.labels[label_name].target_name : ''
    writing_context.append_content(
        word_location,
        "[jump storage=\"#{target_scene.target_name}\.ks\" target=\"#{label}\"]"
    )
  end

end
