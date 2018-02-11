require_relative 'export_graph'

class TyranoDsl::ExportGraph::Main

  # @param [TyranoDsl::Elements::World] world
  # @param [Array<TyranoDsl::ParsedWord>] parsed_words
  # @return [Array<String>]
  def run(world, parsed_words)
    result = []
    result << "digraph G {\n"
    current_scene = nil
    scene_index = 0
    labels_index = {}

    parsed_words.each do |parsed_word|
      case parsed_word.word
        when TyranoDsl::Vocabulary::START_SCENE
          if current_scene
            result << "\t}\n"
            result << "\n"
          end
          current_scene = parsed_word.parameters[:scene_name]
          scene_index += 1
          result << "\tsubgraph cluster_#{scene_index} {\n"
          result << "\t\tlabel = \"#{current_scene}\";\n"
          label_index = labels_index.length
          labels_index["#{current_scene}#start"] = label_index
          result << "\t\tnode [label=\"Start\"] node_#{label_index};\n"
        when TyranoDsl::Vocabulary::DECLARE_LABEL
          label_name = parsed_word.parameters[:label_name]
          label_index = labels_index.length
          labels_index["#{current_scene}##{label_name}"] = label_index
          result << "\t\tnode [label=\"#{label_name}\"] node_#{label_index};\n"
      end
    end
    result << "\t}\n"
    result << "\n"

    current_scene = nil
    current_label = nil
    parsed_words.each do |parsed_word|
      case parsed_word.word
        when TyranoDsl::Vocabulary::START_SCENE
          current_scene = parsed_word.parameters[:scene_name]
          current_label = 'start'
        when TyranoDsl::Vocabulary::DECLARE_LABEL
          label_name = parsed_word.parameters[:label_name]
          from_label = labels_index["#{current_scene}##{current_label}"]
          to_label = labels_index["#{current_scene}##{label_name}"]
          result << "\tnode_#{from_label} -> node_#{to_label};\n"
          current_label = label_name
        when TyranoDsl::Vocabulary::ASK_QUESTION
          parsed_word.parameters[:possible_answers].each do |possible_answer|
            scene_name = possible_answer[:scene]
            label_name = possible_answer[:label] || 'start'
            from_label = labels_index["#{current_scene}##{current_label}"]
            to_label = labels_index["#{scene_name}##{label_name}"]
            result << "\tnode_#{from_label} -> label_#{to_label};\n"
          end
        when TyranoDsl::Vocabulary::JUMP
          scene_name = parsed_word.parameters[:scene_name]
          label_name = parsed_word.parameters[:label_name] || 'start'
          from_label = labels_index["#{current_scene}##{current_label}"]
          to_label = labels_index["#{scene_name}##{label_name}"]
          result << "\tnode_#{from_label} -> node_#{to_label};\n"
        when TyranoDsl::Vocabulary::CONDITIONAL_JUMP
          scene_name = parsed_word.parameters[:scene_name]
          label_name = parsed_word.parameters[:label_name] || 'start'
          from_label = labels_index["#{current_scene}##{current_label}"]
          to_label = labels_index["#{scene_name}##{label_name}"]
          result << "\tnode_#{from_label} -> label_#{to_label};\n"
      end
    end

    result << "}\n"
    result
  end

  # @param [Array<String>] content
  # @param [String] _export_path
  # @return [void]
  def apply(content, _export_path)
    content.each do |entry|
      STDOUT << entry
    end
  end

end