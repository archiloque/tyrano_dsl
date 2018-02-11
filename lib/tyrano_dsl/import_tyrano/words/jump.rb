require_relative 'empty_word'

class TyranoDsl::ImportTyrano::Words::Jump < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(context)
    current_line = context.current_line
    if (match = current_line.match(/\A\[jump\s+storage="(?<scene>[^"]+).ks"\s+target=""\s.\]\n\z/))
      context.add_parsed_word(
          TyranoDsl::Vocabulary::JUMP,
          scene_name: match[:scene]
          )
      context.go_next_line
      context.register_scene(match[:scene])
      true
    elsif (match = current_line.match(/\A\[jump\s+storage="(?<scene>[^"]+).ks"\s+target="\*(?<label>[^"]+)"\s.\]\n\z/))
      context.add_parsed_word(
          TyranoDsl::Vocabulary::JUMP,
          scene_name: match[:scene],
          label_name: match[:label]
          )
      context.go_next_line
      context.register_scene(match[:scene])
      true
    else
      false
    end
  end

end
