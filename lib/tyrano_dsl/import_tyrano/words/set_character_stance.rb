require_relative 'empty_word'

class TyranoDsl::ImportTyrano::Words::SetCharacterStance < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(context)
    current_line = context.current_line
    if (match = current_line.match(/\A\[chara_mod\s+name="(?<name>[^"]+)"\s+time="(?<time>[^"]+)"\s+storage="(?<storage>[^"]+)"\s.\]\n\z/))
      file_path = match[:storage]
      stance_short_name = File.basename(file_path)
      stance_short_name_no_extension = File.basename(file_path, '.*')
      stances = context.characters[match[:name]].stances
      if stances.key?(stance_short_name_no_extension)
        if stances[stance_short_name_no_extension] == file_path
          stance_name = stance_short_name_no_extension
        else
          stances[stance_short_name] = file_path
          stance_name = stance_short_name
        end
      else
        stances[stance_short_name_no_extension] = file_path
        stance_name = stance_short_name_no_extension
      end

      context.add_parsed_word(
          TyranoDsl::Vocabulary::SET_CHARACTER_STANCE,
          character_name: match[:name],
          duration: match[:time].to_i,
          stance: stance_name
      )
      context.go_next_line
      true
    else
      false
    end
  end

end
