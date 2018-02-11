require_relative 'empty_word'

class TyranoDsl::ImportTyrano::Words::ClearMessages < TyranoDsl::ImportTyrano::Words::EmptyWord

  def try_parsing(context)
    current_line = context.current_line
    if current_line.match(/\A\[cm\s*\]\n\z/)
      context.add_parsed_word(
          TyranoDsl::Vocabulary::CLEAR_MESSAGES,
          )
      context.go_next_line
      true
    else
      false
    end
  end

end
