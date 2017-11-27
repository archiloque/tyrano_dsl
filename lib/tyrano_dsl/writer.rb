require_relative 'writers/character_writer'

module TyranoDsl

  class Writer

    CHARACTERS_FILE = 'chara_define.ks'.freeze

    # @param [!TyranoDsl::World] world
    # @return [Array] the writing actions
    def write_world(world)
      writing_actions = []
      character_writer = TyranoDsl::Writers::CharacterWriter.new
      world.characters.each do |character|
        writing_actions.concat character_writer.write(world, character)
      end
      writing_actions
    end

  end

end