require_relative '../vocabulary'

module TyranoDsl
  module Words
    class DeclareScene

      def parse(context, parameters)
        if parameters.length != 1
          raise "You should have one parameter specifying the scene name but you have #{parameters.length}: #{parameters}"
        end
        context.add_word(TyranoDsl::Vocabulary::DECLARE_SCENE, scene_name: parameters[0])
      end
    end
  end
end
