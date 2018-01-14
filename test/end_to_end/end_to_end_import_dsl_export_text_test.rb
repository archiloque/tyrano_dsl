require_relative '../test_helper'

require_relative '../../lib/tyrano_dsl/main'

class EndToEndImportDslExportTextTest < Minitest::Test

  # @return [TyranoDsl::ExportTyrano::WritingContext]
  def run_on_file(file_path)
    TyranoDsl::Main.new('dsl', 'text', File.absolute_path(file_path, __dir__), nil).export_result
  end

  def full_path(file_path)
    File.absolute_path(file_path, __dir__)
  end

  def test_end_to_end_export_text
    content = run_on_file('end_to_end_scene.rb')
    assert_equal(
        [
            "Hello!\n",
            "Shinji\n",
            "Hello!\n",
            "  Yes !\n",
            "  No \"\"?\n",
            "Hello from included scene!\n",
        ], content)

  end

end