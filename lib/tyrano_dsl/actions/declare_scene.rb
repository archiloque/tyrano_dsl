require_relative '../elements/scene'

module TyranoDsl
  module Actions
    class DeclareScene
      def run(game, parameters)
        game.scenes[parameters[0]] = TyranoDsl::Elements::Scene.new(parameters[0])
      end
    end
  end
end
