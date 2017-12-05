require_relative 'files_actions_module'

module TyranoDsl
  module Writers
    module FileActions

      # Remove all files from a directory
      class ClearDirectory

        include TyranoDsl::Writers::FileActions::FileActionsModule

        attr_reader :path

        # @param [String] path
        def initialize(path)
          @path = path
          log{self.to_s}
        end


        # @param [String] tyrano_project_path
        def run(tyrano_project_path)

        end

        def to_s
          "Clear directory [#{path}]"
        end


      end
    end
  end
end