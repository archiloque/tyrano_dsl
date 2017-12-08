require 'logger'

module TyranoDsl
  module FileActions

    # Helpers to write file actions
    module FileActionsModule

      protected

      def create_parent_dir_if_not_exist(file_path)
        parent_dir = File.dirname(file_path)
        unless File.exists? parent_dir
          FileUtils.mkdir_p parent_dir
        end
      end

      def logger
        @logger ||= Logger.new(STDOUT)
      end

      def log
        logger.info(self.class) {yield}
      end

    end
  end
end