require_relative '../../../../lib/tyrano_dsl/validation/words/declare_label'
require_relative 'words_base_test'

class ValidationWords::DeclareLabelTest < ValidationWords::WordsBaseTest

  def setup
    super
    @declare_label = TyranoDsl::Validation::Words::DeclareLabel.new
  end

  def test_duplicated_label
    declare_scene(@world, 'scene name')
    declare_label(@world, 'scene name', 'label name')
    @context.current_scene = @world.scenes['scene name']
    assert_tyrano_exception('Duplicated label [label name]') do
      @declare_label.world_construction_phase(
          @context,
          @world,
          caller,
          label_name: 'label name'
      )
    end
  end

  def test_ok
    declare_scene(@world, 'scene name')
    @context.current_scene = @world.scenes['scene name']
    @declare_label.world_construction_phase(
        @context,
        @world,
        caller,
        label_name: 'label name'
    )
    assert_equal(1, @context.current_scene.labels.length)
    assert_equal('label name', @context.current_scene.labels.first)
  end

end
