require_relative 'actions_module'

module TyranoDsl
  module Actions

    # @!macro word_jump_to
    class JumpTo

      include TyranoDsl::Actions::ActionsModule

      # @!macro action_run
      def run(writing_context, world, word_location, parameters)
        scene_name = parameters[:name]
        unless world.scenes.key? scene_name
          raise ::TyranoDsl::TyranoException, "Line #{word_location.lineno} unknown scene [#{scene_name}], currently defined: #{world.scenes.keys.sort.join(', ')}"
        end
        # @todo
      end

    end
  end
end
