require_relative 'words_base_test'

class ImportDslWords::DeclareLabelTest < ImportDslWords::WordsBaseTest

  def test_ok
    @parser.declare_label('my_label')
    assert_word_equal(
        TyranoDsl::Vocabulary::DECLARE_LABEL,
        label_name: 'my_label'
    )
  end

end
