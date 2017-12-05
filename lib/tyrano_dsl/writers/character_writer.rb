require_relative 'file_actions/file_copy_action'
require_relative 'writers_module'

module TyranoDsl

  module Writers

    # Write a character
    class CharacterWriter

      include ::TyranoDsl::Writers::WritersModule

      # @param [TyranoDsl::Elements::World] world
      # @param [TyranoDsl::Elements::Character] character
      # @return [Array]
      def write(world, character)
        log {"Writing character [#{character.name}]"}
        # @todo
        []
      end

    end
  end

end