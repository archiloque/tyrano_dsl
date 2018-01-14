require_relative 'writing_words_module'

class TyranoDsl::ExportTyrano::WritingWords::AskQuestion

  include TyranoDsl::ExportTyrano::WritingWords::WritingWordsModule

  def run(writing_context, world, word_location, parameters)
    content = []
    parameters[:possible_answers].each do |possible_answer|
      text = possible_answer[:text]
      scene_name = possible_answer[:scene]
      label_name = possible_answer[:label]
      top = possible_answer[:top]
      left = possible_answer[:left]
      target_scene = fetch_scene(world, word_location, scene_name)

      label = label_name ? world.labels[label_name].target_name : ''

      content << "[glink color=\"black\" storage=\"#{target_scene.target_name}\" target=\"#{label}\" size=\"20\" x=\"#{left}\" y=\"#{top}\" text=\"#{h(text)}\"]\n"
    end
    content << "[s]\n"
    writing_context.append_content(
        word_location,
        content.join
    )
  end

end