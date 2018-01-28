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

    def run_on_file(file_path, import_format, export_format)
      @main = TyranoDsl::Main.new(import_format, export_format, File.absolute_path(file_path, __dir__), nil)
      @main.export_result
    end

    def full_path(file_path)
      File.absolute_path(file_path, __dir__)
    end


  end

end
