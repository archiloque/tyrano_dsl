require_relative 'files_actions_module'

module TyranoDsl
  module Writers
    module FileActions

      # Direct copy of a file from a source to a destination
      class FileCopyAction
        attr_reader :from_path, :to_path

        include TyranoDsl::Writers::FileActions::FileActionsModule

        # @param [String] from_path
        # @param [String] to_path
        def initialize(from_path, to_path)
          @from_path = from_path
          @to_path = to_path
          log {self.to_s}
        end


        # @param [String] tyrano_project_path
        def run(tyrano_project_path)

        end

        def to_s
          "Copy file [#{from_path}] to [#{to_path}]"
        end

      end
    end
  end
end