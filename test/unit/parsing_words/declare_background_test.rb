require_relative 'parsing_words_helper'
require_relative '../../../lib/tyrano_dsl/parser'

class DeclareBackgroundTest < Minitest::Test

  include ParsingWorldsHelper

  def test_missing_background
    parsing_context = create_parsing_context
    parser = TyranoDsl::Parser.new(parsing_context)
    begin
      parser.declare_background('missing background', 'missing_file.png')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 12 missing file [missing_file.png]'
    end
  end

  def test_duplicated_background
    parsing_context = create_parsing_context
    parser = TyranoDsl::Parser.new(parsing_context)
    parser.declare_background('background', '../../assets/backgrounds/school.jpg')
    begin
      parser.declare_background('background', '../../assets/backgrounds/school.jpg')
      fail
    rescue TyranoDsl::TyranoException => e
      assert_equal e.message, 'Line 24 duplicated background [background]'
    end
  end

end
