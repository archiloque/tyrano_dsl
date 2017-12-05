require 'logger'

module TyranoDsl
  module Writers

    module FileActions

      # Helpers to write file actions
      module FileActionsModule

        def logger
          @logger ||= Logger.new(STDOUT)
        end

        def log()
          logger.info(self.class) {yield}
        end

      end
    end
  end
end