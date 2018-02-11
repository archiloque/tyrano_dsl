require_relative 'empty_word'

class TyranoDsl::ImportTyrano::Words::DeclareLabel < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(context)
    current_line = context.current_line
    if (match = current_line.match(/\A\*(?<label>[^\n]+)\n\z/))
      context.add_parsed_word(
          TyranoDsl::Vocabulary::DECLARE_LABEL,
          label_name: match[:label]
          )
      context.go_next_line
      true
    else
      false
    end
  end

end
