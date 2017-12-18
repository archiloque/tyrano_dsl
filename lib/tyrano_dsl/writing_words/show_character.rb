require_relative 'writing_words_module'

class TyranoDsl::WritingWords::ShowCharacter

  def run(writing_context, world, word_location, parameters)
    character = world.characters[parameters[:name]]
    character_stance = parameters[:stance]
    left = parameters[:left]
    top = parameters[:top]
    # chara_show display the default stance, so we display the real stance after is it's not the default
    writing_context.add_asset_loading(
        word_location,
        character.stances[character_stance].long_target_file_name
    )
    writing_context.append_content(
        word_location,
        "[chara_show name=\"#{character.name}\" time=\"1000\" wait=\"true\" left=\"#{left}\" top=\"#{top}\" width=\"\" height=\"\" reflect=\"false\"]"
    )
    unless character_stance == :default
      writing_context.add_asset_loading(
          word_location,
          character.default_stance.long_target_file_name
      )
      writing_context.append_content(
          word_location,
          "[chara_mod name=\"#{character.name}\" cross=\"true\" storage=\"#{character.stances[character_stance].short_target_file_name}\"]"
      )
    end
  end

end
