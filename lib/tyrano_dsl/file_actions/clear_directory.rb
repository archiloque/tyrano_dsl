require 'fileutils'

require_relative 'files_actions_module'

module TyranoDsl
  module FileActions

    # Remove all files from a directory
    class ClearDirectory

      include TyranoDsl::FileActions::FileActionsModule

      attr_reader :path

      # @param [String] path
      def initialize(path)
        @path = path
        log {to_s}
      end

      # @param [String] tyrano_project_path
      def run(tyrano_project_path)
        full_path = File.join(tyrano_project_path, path)
        log {"Cleaning [#{full_path}]"}
        if File.exists? full_path
          FileUtils.remove_entry full_path
        end
        FileUtils.mkdir_p full_path
      end

      def to_s
        "Clear directory [#{path}]"
      end

    end
  end
end