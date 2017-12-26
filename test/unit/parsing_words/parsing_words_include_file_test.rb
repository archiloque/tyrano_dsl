require_relative 'parsing_words_test_helper'

class ParsingWordsIncludeFileTest < Minitest::Test

  include ParsingWordsTestHelper

  def test_missing_file
    parser = create_parser
    begin
      parser.include_file('missing_file.rb')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal(e.message, "File not found [#{full_path('missing_file.rb')}]")
    end
  end

end
