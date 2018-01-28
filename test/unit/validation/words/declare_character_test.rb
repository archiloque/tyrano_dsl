require_relative '../../../../lib/tyrano_dsl/validation/words/declare_character'
require_relative 'words_base_test'

class ValidationWords::DeclareCharacterTest < ValidationWords::WordsBaseTest

  def setup
    super
    @declare_character = TyranoDsl::Validation::Words::DeclareCharacter.new
  end

  def test_missing_image
    assert_tyrano_exception("Missing file [missing_file.png]") do
      @declare_character.world_construction_phase(
          @context,
          @world,
          caller,
          character_name: 'character',
          stances: {:default => 'missing_file.png'})
    end
  end

  def test_duplicated_character
    declare_character(@world, 'character', :default => '../../../../assets/characters/shinji/default_stance.jpg')
    assert_tyrano_exception('Duplicated character [character]') do
      @declare_character.world_construction_phase(
          @context,
          @world,
          caller,
          character_name: 'character',
          stances: {:default => '../../../../assets/characters/shinji/default_stance.jpg'})
    end
  end

  def test_no_default_stance
    assert_tyrano_exception('A default stance is required') do
      @declare_character.world_construction_phase(
          @context,
          @world,
          caller,
          character_name: 'character',
          stances: {:plop => '../../../../assets/characters/shinji/default_stance.jpg'})
    end
  end

  def test_ok
    @declare_character.world_construction_phase(
        @context,
        @world,
        caller,
        character_name: 'character',
        stances: {:default => full_path('../../../assets/characters/shinji/default_stance.jpg')})

    assert_equal(1, @world.characters.length)
    assert_equal('character', @world.characters.keys.first)
    character = @world.characters.values.first
    assert_equal('character', character.name)
    assert_equal(1, character.stances.length)
    assert_equal(:default, character.stances.keys.first)

    stance = character.stances.values.first
    assert_equal(:default, stance.name,)
    assert_equal(full_path('../../../assets/characters/shinji/default_stance.jpg'), stance.file_name)

    default_stance = character.default_stance
    assert_equal(:default, default_stance.name)
    assert_equal(full_path('../../../assets/characters/shinji/default_stance.jpg'), default_stance.file_name)
  end

end
