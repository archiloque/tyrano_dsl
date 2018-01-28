require_relative 'words_base_test'

class ImportDslWords::IncludeFileTest < ImportDslWords::WordsBaseTest

  def test_missing_file
    assert_tyrano_exception("File not found [#{full_path('missing_file.rb')}]") do
      @parser.include_file('missing_file.rb')
    end
  end

end
