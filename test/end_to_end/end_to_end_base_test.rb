require_relative '../test_helper'
require_relative '../../lib/tyrano_dsl/main'

module EndToEndTest

  class BaseTest < Minitest::Test

    protected

    def extract_by_class(array, class_to_be_found)
      array.select do |i|
        i.class == class_to_be_found
      end
    end

    def run_on_file(import_format, export_format, import_path, export_path = nil)
      @main = TyranoDsl::Main.new(
          import_format,
          export_format,
          File.absolute_path(import_path, __dir__),
          export_path ? File.absolute_path(export_path, __dir__) : nil
      )
      @main.export_result
    end

    def full_path(file_path)
      File.absolute_path(file_path, __dir__)
    end

    # @param [Array<TyranoDsl::FileActions::BaseFileAction>] file_actions
    # @return [Hash{String=>String}]
    def create_file_copies_hash(file_actions)
      file_copies = extract_by_class(file_actions, TyranoDsl::FileActions::FileCopy)
      files_copies = {}
      file_copies.each do |file_copy_action|
        files_copies[file_copy_action.to_path] = file_copy_action.from_path
      end
      files_copies
    end

    # @param [String] base_directory
    # @param [Array<TyranoDsl::FileActions::BaseFileAction>] file_actions
    # @param [Integer] expected_length
    # @return [nil]
    def check_files_contents(base_directory, file_actions, expected_length)
      create_files = extract_by_class(file_actions, TyranoDsl::FileActions::CreateFile)
      assert_equal(create_files.length, expected_length)
      create_files.each do |create_file_action|
        assert_equal(
            IO.read(File.join(__dir__, base_directory, create_file_action.path.gsub('/', '#'))),
            create_file_action.content
        )
      end
    end

  end

end
