require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::ShowCharacter < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, world, parameters)
    character_name = parameters[:character_name]
    character = world.characters[character_name]
    character_stance_name = parameters[:stance]
    left = parameters[:left]
    top = parameters[:top]
    # chara_show display the default stance, so we display the real stance after if it's not the default
    context.add_asset_loading(
        context.stance_long_file_name(character_name, character_stance_name)
    )
    context.append_content(
        "[chara_show name=\"#{character_name}\" time=\"1000\" wait=\"true\" left=\"#{left}\" top=\"#{top}\" width=\"\" height=\"\" reflect=\"false\"]"
    )
    unless character_stance_name == :default
      context.add_asset_loading(
          context.stance_long_file_name(character_name, character.default_stance.name)
      )
      context.append_content(
          "[chara_mod name=\"#{character_name}\" cross=\"true\" storage=\"#{context.stance_short_file_name(character_name, character_stance_name)}\"]"
      )
    end
  end

end
