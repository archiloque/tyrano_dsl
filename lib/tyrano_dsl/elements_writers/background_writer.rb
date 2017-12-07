require_relative '../elements/background'
require_relative '../file_actions/clear_directory'
require_relative '../file_actions/file_copy_action'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write a background
    class BackgroundWriter

      include ::TyranoDsl::ElementsWriters::ElementsWritersModule

      # @return [Array]
      def init_actions
        [
            TyranoDsl::FileActions::ClearDirectory.new(TyranoDsl::Elements::Background::BACKGROUND_DIRECTORY)
        ]
      end

      # @param [TyranoDsl::Elements::World] world
      # @param [TyranoDsl::Elements::Background] background
      # @return [Array]
      def write(world, background)
        log {"Writing background [#{background.name}]"}
        [
            TyranoDsl::FileActions::FileCopyAction.new(
                background.image_path,
                background.target_long_file_name
            )
        ]
      end

    end
  end

end