require 'cgi'

module TyranoDsl
  module WritingWords

    # A module to help writing writing word
    module WritingWordsModule

      # Get a scene from its name
      # @param [TyranoDsl::Elements::World] world
      # @param [Array<Thread::Backtrace::Location>] word_location
      # @param [String] scene_name
      # @return [TyranoDsl::Elements::Scene]
      # @raise [TyranoDsl::TyranoException]
      def fetch_scene(world, word_location, scene_name)
        target_scene = world.scenes[scene_name]
        unless target_scene
          raise TyranoDsl::TyranoException, "Line #{word_location[0].lineno} unknown scene [#{scene_name}], currently defined: #{world.scenes.keys.sort.join(', ')}"
        end
        target_scene
      end

      # HTML escape text
      # @param [String] text
      # @return [String]
      def h(text)
        CGI::escapeHTML(text)
      end

    end
  end
end
