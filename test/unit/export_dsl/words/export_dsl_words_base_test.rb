require_relative '../../../../lib/tyrano_dsl/elements/world'
require_relative '../../../../lib/tyrano_dsl/export_dsl/context'
require_relative '../../unit_test_helper'

module ExportDslWords

  class WordsBaseTest < Minitest::Test
    include UnitTestHelper

    protected

    def setup
      @world = create_world
      @context = create_context(@world)
    end


    def create_world
      TyranoDsl::Elements::World.new
    end

    def create_context(world)
      TyranoDsl::ExportDsl::Context.new(world)
    end

    def assert_main_file(content)
      main_file = @context.file_actions.find {|fa| fa.is_a?(TyranoDsl::FileActions::CreateFile) && (fa.path == 'main.rb')}
      assert_equal(content, main_file.content)
    end
  end

end