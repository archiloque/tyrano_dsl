require_relative '../elements/character'
require_relative '../file_actions/clear_directory'
require_relative '../file_actions/file_copy'
require_relative 'elements_writers_module'

module TyranoDsl

  module ElementsWriters

    # Write a character
    class CharacterWriter

      include ::TyranoDsl::ElementsWriters::ElementsWritersModule

      # @return [Array]
      def init_actions
        [
            TyranoDsl::FileActions::ClearDirectory.new(TyranoDsl::Elements::Character::CHARACTER_DIRECTORY)
        ]
      end

      # @param [TyranoDsl::Elements::Character] character
      # @return [Array]
      def write(character)
        log {"Writing character [#{character.name}]"}
        # @todo
        result = []
        character.stances.each_pair do |stance_name, stance_file|
          result << TyranoDsl::FileActions::FileCopy.new(
              stance_file,
              character.stances_target_long_files_names[stance_name]
          )
        end
        result
      end

    end
  end

end