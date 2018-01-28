require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/intermediate/context'
require_relative '../../unit_test_helper'

module IntermediateWords

  class WordsBaseTest < Minitest::Test

    include UnitTestHelper

    def setup
      @context = create_context
      @world = create_world
    end

    protected

    def full_path(file_path)
      File.absolute_path(file_path, __dir__)
    end

    def create_context
      TyranoDsl::Intermediate::Context.new
    end

    def create_world
      TyranoDsl::Elements::World.new
    end

    def create_word(word, parameters)
      TyranoDsl::ParsedWord.new(
          word,
          caller,
          parameters
      )
    end

  end
end