require_relative '../../../../lib/tyrano_dsl/validation/words/declare_background'
require_relative 'words_base_test'

class ValidationWords::DeclareBackgroundTest < ValidationWords::WordsBaseTest

  def setup
    super
    @declare_background = TyranoDsl::Validation::Words::DeclareBackground.new
  end

  def test_missing_image
    assert_tyrano_exception("Missing file [missing_file.png]") do
      @declare_background.world_construction_phase(
          @context,
          @world,
          caller,
          background_name: 'background',
          image_path: 'missing_file.png')
    end
  end

  def test_duplicated_background
    declare_background(@world, 'background', full_path('../../../assets/backgrounds/school.jpg'))
    assert_tyrano_exception('Duplicated background [background]') do
      @declare_background.world_construction_phase(
          @context,
          @world,
          caller,
          background_name: 'background',
          image_path: full_path('../../../assets/backgrounds/school.jpg'))
    end
  end

  def test_ok
    @declare_background.world_construction_phase(
        @context,
        @world,
        caller,
        background_name: 'background',
        image_path: full_path('../../../assets/backgrounds/school.jpg'))
    assert_equal(1, @world.backgrounds.length)
    assert_equal('background', @world.backgrounds.keys.first)
    background = @world.backgrounds.values.first
    assert_equal('background', background.name,)
    assert_equal(full_path('../../../assets/backgrounds/school.jpg'), background.image_path)
  end

end
