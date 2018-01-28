require_relative '../../../../lib/tyrano_dsl/intermediate/words/update_variable'
require_relative 'words_base_test'

class IntermediateWords::UpdateVariableTest < IntermediateWords::WordsBaseTest

  def setup
    super
    @update_variable = TyranoDsl::Intermediate::Words::UpdateVariable.new
  end

  def test_unknown_variable
    assert_tyrano_exception('Unknown variable [a]') do
      @update_variable.validation_phase(
          @context,
          @world,
          caller,
          operator: '=', variable: 'a', value: 10
      )
    end
  end

  def test_unknown_operator
    declare_variable(@world, ' a ', 10)
    assert_tyrano_exception('Unknown operator [?]') do
      @update_variable.validation_phase(
          @context,
          @world,
          caller,
          operator: '?', variable: 'a', value: 10
      )
    end
  end

  def test_unknown_value_variable
    declare_variable(@world, 'a', 10)
    assert_tyrano_exception('Unknown variable [b]') do
      @update_variable.validation_phase(
          @context,
          @world,
          caller,
          operator: '=', variable: 'a', value: 'b'
      )
    end
  end

  def test_ok_value
    declare_variable(@world, 'a', 10)
    @update_variable.validation_phase(
        @context,
        @world,
        caller,
        operator: '=', variable: 'a', value: 10
    )
  end

  def test_ok_variable
    declare_variable(@world, 'a', 10)
    declare_variable(@world, 'b', 12)
    @update_variable.validation_phase(
        @context,
        @world,
        caller,
        operator: '=', variable: 'a', value: 'b'
    )
  end

end
