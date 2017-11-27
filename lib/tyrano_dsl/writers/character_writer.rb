require_relative 'writing_actions/file_copy_action'

module TyranoDsl

  module Writers

    class CharacterWriter

      # @param [!TyranoDsl::Elements::World] world
      # @param [!TyranoDsl::Elements::Character] character
      # @return [!Array<TyranoDsl::Writers::WritingActions::FileCopyAction>]
      def write(world, character)
        []
      end

    end
  end

end