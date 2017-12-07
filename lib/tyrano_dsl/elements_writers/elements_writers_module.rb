require 'logger'

module TyranoDsl
  module ElementsWriters

    # Helpers to write writers
    module ElementsWritersModule

      protected

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def log
        logger.info(self.class) {yield}
      end

    end
  end
end
