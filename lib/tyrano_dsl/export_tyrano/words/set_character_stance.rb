require_relative 'base_word'
require_relative '../../elements/character'
require_relative 'words'

class TyranoDsl::ExportTyrano::Words::SetCharacterStance < TyranoDsl::ExportTyrano::Words::BaseWord

  # @param [TyranoDsl::Intermediate::Context] context
  # @param [TyranoDsl::Elements::World] world
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :character_name
  # @option parameters [String] :stance
  def run(context, world, parameters)
    character_name = parameters[:character_name]
    character_stance = parameters[:stance]

    context.add_asset_loading(
        context.stance_long_file_name(character_name, character_stance)
    )
    context.append_content(
        "[chara_mod name=\"#{character_name}\" time=\"#{parameters[:duration]}\" cross=\"true\" storage=\"chara/#{context.stance_short_file_name(character_name, character_stance)}\"]"
    )
  end

end