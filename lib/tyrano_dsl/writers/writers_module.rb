require 'logger'

module TyranoDsl
  module Writers

    # Helpers to write writers
    module WritersModule

      protected

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def log
        logger.info(self.class){yield}
      end

    end
  end
end
