require_relative 'actions/declare_scene'
require_relative 'elements/game'
require_relative 'vocabulary'

module TyranoDsl
  class Demiurge

    include Vocabulary

    def initialize()
      @words = {
          DECLARE_SCENE => ::TyranoDsl::Actions::DeclareScene.new
      }
    end

    def create_game(parsing_context)
      p 'Creating game'
      game = Elements::Game.new
      parsing_context.words.each do |word|
        p "Processing word #{word}"
        word_name = word[:word]
        word_action = @words[word_name]
        unless word_action
          raise "Unknown word [#{word_name}]"
        end
        word_action.run(game, word[:parameters])
      end
      p 'Game created'
      game
    end

  end
end