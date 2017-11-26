require_relative 'demiurge'
require_relative 'parsing_context'
require_relative 'reader'
require_relative 'writer'

module TyranoDsl

  class Main

    DEFAULT_FILENAME = 'content.rb'.freeze

    def run
      content_file_path = File.expand_path(DEFAULT_FILENAME)
      p "Reading content file at [#{content_file_path}]"
      unless File.exist? content_file_path
        raise "File not found [#{content_file_path}]"
      end

      parsing_context = ParsingContext.new
      reader = Reader.new(parsing_context)
      reader.instance_eval(IO.read(content_file_path))

      game = Demiurge.new.create_game(parsing_context)
      game.validate

       Writer.new.write_game(game)
    end

  end
end