require_relative '../et_helper'

module ExportTyranoWords

  class WordsBaseTest < Minitest::Test

    include ETHelper

    def setup
      @world = create_world
      @context = create_context(@world)
    end


  end

end
