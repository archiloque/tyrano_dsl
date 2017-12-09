require 'json'

require_relative 'files_actions_module'

module TyranoDsl
  module FileActions

    # Path a JSON file
    # @attr [String] file_path
    # @attr [Array<String>] patching_path
    # @attr [Object] patched_content
    class JsonPatch

      include TyranoDsl::FileActions::FileActionsModule

      attr_reader :file_path, :patching_path, :patched_content

      # @param [String] file_path
      # @param [Array<String>] patching_path
      # @param [Object] patched_content
      def initialize(file_path, patching_path, patched_content)
        @file_path = file_path
        @patching_path = patching_path
        @patched_content = patched_content
        log {self.to_s}
      end

      # @param [String] tyrano_project_path
      def run(tyrano_project_path)
        full_path = File.join(tyrano_project_path, file_path)
        log {"Patching file [#{full_path}] at #{patching_path}"}
        unless File.exist? full_path
          raise TyranoDsl::TyranoException, "Missing file [#{full_path}]"
        end
        content = JSON.parse(IO.read(full_path))
        current_subtree = content
        0.upto(patching_path.length - 2) do |path_segment_index|
          current_subtree = current_subtree[patching_path[path_segment_index]]
        end
        current_subtree[patching_path.last] = patched_content
        File.write(full_path, JSON.pretty_generate(content))
      end

      def to_s
        "Patch JSON [#{file_path}] at #{patching_path}"
      end

    end
  end
end