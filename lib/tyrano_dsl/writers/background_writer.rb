require_relative 'file_actions/clear_directory'
require_relative 'file_actions/file_copy_action'
require_relative 'writers_module'

module TyranoDsl

  module Writers

    # Write a background
    class BackgroundWriter

      include ::TyranoDsl::Writers::WritersModule

      BACKGROUND_DIRECTORY = 'bgimage'

      # @return [Array]
      def init_actions
        [
            ::TyranoDsl::Writers::FileActions::ClearDirectory.new(BACKGROUND_DIRECTORY)
        ]
      end

      # @param [TyranoDsl::Elements::World] world
      # @param [TyranoDsl::Elements::Background] background
      # @return [Array]
      def write(world, background)
        log {"Writing background [#{background.name}]"}
        [
            ::TyranoDsl::Writers::FileActions::FileCopyAction.new(
                background.image_path,
                File.join(BACKGROUND_DIRECTORY, background.target_file_name)
            )
        ]
      end

    end
  end

end