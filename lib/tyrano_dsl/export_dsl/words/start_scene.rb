require_relative 'words'

class TyranoDsl::ExportDsl::Words::StartScene

  # @param [TyranoDsl::ExportDsl::Context] context
  # @param [Array<String>] _word_location
  # @param [Hash{Symbol=>Object}] parameters
  # @option parameters [String] :scene_name
  # @return [void]
  def run(context, _word_location, parameters)
    context.init_new_scene(parameters[:scene_name])
  end

end