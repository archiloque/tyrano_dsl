require 'json'

require_relative '../../../../lib/tyrano_dsl/import_tyrano/readers/variables'
require_relative 'readers_base_test'

class ImportTyranoWriters::VariablesWriterTest < ImportTyranoWriters::ReadersBaseTest

  def test_ok
    variables_reader = TyranoDsl::ImportTyrano::Readers::Variables.new
    builder_file_content = {
        TyranoDsl::TyranoConstants::BUILDER_CONFIG_VARIABLE_PATH =>
            {
                "variable_1":
                    {
                        "val": 25,
                        "kind": "f"
                    },
                "variable_2":
                    {
                        "val": nil,
                        "kind": "f"
                    },
                "variable_3":
                    {
                        "val": "plop",
                        "kind": "f"
                    },
            }
    }
    chara_file_content = "f['first_name']='';
f['last_name']='';
f['money']=50;
f['cat']='cute';"

    parsed_words = variables_reader.read(
        create_file_accessor(
            File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE) =>
                JSON.generate(builder_file_content),
            File.join(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE) =>
                chara_file_content
        ))

    assert_word_equal(parsed_words[0], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'cat', initial_value: 'cute')
    assert_word_equal(parsed_words[1], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'first_name', initial_value: nil)
    assert_word_equal(parsed_words[2], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'last_name', initial_value: nil)
    assert_word_equal(parsed_words[3], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'money', initial_value: 50)
    assert_word_equal(parsed_words[4], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'variable_1', initial_value: 25)
    assert_word_equal(parsed_words[5], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'variable_2', initial_value: nil)
    assert_word_equal(parsed_words[6], TyranoDsl::Vocabulary::DECLARE_VARIABLE, variable_name: 'variable_3', initial_value: 'plop')
  end

end
