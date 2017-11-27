module TyranoDsl
  module Writers
    module WritingActions
      class FileCopyAction
        attr_reader :from_path, :to_path

        def initialize(from_path, to_path)
          @from_path = from_path
          @to_path = to_path
        end


        def run

        end

      end
    end
  end
end