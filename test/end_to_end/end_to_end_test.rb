require 'pathname'
require 'minitest/autorun'
require_relative '../../lib/tyrano_dsl/main'
require_relative '../../lib/tyrano_dsl/vocabulary'
require_relative '../../lib/tyrano_dsl/tyrano_exception'

class EndToEndTest < Minitest::Test

  def run_on_file(file_path)
    TyranoDsl::Main.new.run(File.join(__dir__, file_path))
  end

  def validate_exception(file_path, exception_message)
    begin
      run_on_file(file_path)
    rescue ::TyranoDsl::TyranoException => e
      assert_equal(e.message, exception_message)
    end
  end

  def test_missing_file
    validate_exception(
        'missing_file.rb',
        "Line 1 missing file [missing_file.png]"
    )
  end

  def test_simple_scene
    writing_context = run_on_file('simple_scene.rb')
    p writing_context.world.inspect
  end

end