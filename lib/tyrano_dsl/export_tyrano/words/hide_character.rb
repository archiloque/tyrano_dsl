require_relative 'base_word'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::HideCharacter < TyranoDsl::ExportTyrano::Words::BaseWord

  def run(context, world, parameters)
    character = world.characters[parameters[:character_name]]
    context.append_content(
        "[chara_hide name=\"#{character.name}\" time=\"1000\" wait=\"true\"]"
    )
  end

end