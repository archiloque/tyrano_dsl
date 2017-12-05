require_relative 'files_actions_module'

module TyranoDsl
  module Writers
    module FileActions
      class CreateFileAction

        include TyranoDsl::Writers::FileActions::FileActionsModule

        attr_reader :path, :content

        # @param [!String] path
        # @param [!String] content
        def initialize(path, content)
          @path = path
          @content = content
          log{self.to_s}
        end

        # @param [!String] tyrano_project_path
        def run(tyrano_project_path)

        end

        def to_s
          "Create file [#{path}]"
        end

      end
    end
  end
end