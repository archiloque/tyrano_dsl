require_relative '../test_helper'

require_relative '../../lib/tyrano_dsl/export_text/main'
require_relative '../../lib/tyrano_dsl/import_dsl/main'
require_relative '../../lib/tyrano_dsl/tyrano_exception'
require_relative '../../lib/tyrano_dsl/vocabulary'

class EndToEndExportTextTest < Minitest::Test

  # @return [TyranoDsl::ExportTyrano::WritingContext]
  def run_on_file(file_path)
    import_result = TyranoDsl::ImportDsl::Main.new.run(File.absolute_path(file_path, __dir__))
    TyranoDsl::ExportText::Main.new.run(import_result[:world], import_result[:words])
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