require 'cgi'

module TyranoDsl::ExportTyrano
  module WritingWords

    # A module to help writing writing word
    module WritingWordsModule

      # Get a scene from its name
      # @param [TyranoDsl::Elements::World] world
      # @param [Array<String>] word_location
      # @param [String] scene_name
      # @return [TyranoDsl::Elements::Scene]
      # @raise [TyranoDsl::TyranoException] if the scene does not exist
      def fetch_scene(world, word_location, scene_name)
        target_scene = world.scenes[scene_name]
        unless target_scene
          raise_unknown('scene', scene_name, world.scenes.keys, word_location)
        end
        target_scene
      end

      # HTML escape text
      # @param [String] text
      # @return [String]
      def h(text)
        CGI::escapeHTML(text)
      end

      # @param [String] type
      # @param [String] unknown_name
      # @param [Array<String>] current_elements
      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def raise_unknown(type, unknown_name, current_elements, word_location)
        exception = TyranoDsl::TyranoException.new("Unknown #{type} [#{unknown_name}], currently #{current_elements.length} defined: #{current_elements.sort.collect {|e| "[#{e}]"}.join(', ')}")
        exception.set_backtrace word_location
        raise exception
      end

    end
  end
end
