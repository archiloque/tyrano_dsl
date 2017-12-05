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
        "Line 1 missing file [#{File.join(__dir__, 'missing_file.png')}]"
    )
  end

  def test_unknown_word
    validate_exception(
        'unknown_word.rb',
        "Line 1 unknown word [unknown_word], available words are: #{TyranoDsl::Vocabulary::ALL_WORDS.join(', ')}"
    )
  end

  def test_missing_parameter
    validate_exception(
        'missing_parameter.rb',
        "Line 1 you should have 1 parameter(s) specifying the scene name but you have 0 parameters : []"
    )
  end


  def test_too_many_parameters
    validate_exception(
        'too_many_parameters.rb',
        "Line 1 you should have 1 parameter(s) specifying the scene name but you have 2 parameters : [\"a\", \"b\"]"
    )
  end

  def test_simple_scene
    writing_context = run_on_file('simple_scene.rb')
    p writing_context.world.inspect
  end

end