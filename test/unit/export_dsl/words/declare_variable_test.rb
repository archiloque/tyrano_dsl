require_relative 'export_dsl_words_base_test'
require_relative '../../../../lib/tyrano_dsl/export_dsl/words/declare_variable'

class ExportDslWords::DeclareVariableTest < ExportDslWords::WordsBaseTest

  def test_string
    declare_variable = TyranoDsl::ExportDsl::Words::DeclareVariable.new
    declare_variable.run(@context,
                         variable_name: 'variable_name',
                         initial_value: 'yolo')
    @context.end_writing
    assert_main_file('declare_variable "variable_name", "yolo"')
  end

  def test_float
    declare_variable = TyranoDsl::ExportDsl::Words::DeclareVariable.new
    declare_variable.run(@context,
                         variable_name: 'variable_name',
                         initial_value: 12)
    @context.end_writing
    assert_main_file('declare_variable "variable_name", 12')
  end

  def test_empty
    declare_variable = TyranoDsl::ExportDsl::Words::DeclareVariable.new
    declare_variable.run(@context,
                         variable_name: 'variable_name')
    @context.end_writing
    assert_main_file('declare_variable "variable_name"')
  end

end
