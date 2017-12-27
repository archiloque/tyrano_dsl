require_relative 'parsing_words_test_helper'

class ParsingWordsIncludeFileTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_file
    parser = create_parser
    assert_tyrano_exception("File not found [#{full_path('missing_file.rb')}]") do
      parser.include_file('missing_file.rb')
    end
  end

end
