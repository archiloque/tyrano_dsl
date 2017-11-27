require_relative 'demiurge'
require_relative 'parsing_context'
require_relative 'reader'
require_relative 'writer'

module TyranoDsl

  class Main

    DEFAULT_FILENAME = 'content.rb'.freeze

    def run(file_path)
      content_file_path = File.expand_path(file_path)
      p "Reading content file at [#{content_file_path}]"
      unless File.exist? content_file_path
        raise "File not found [#{content_file_path}]"
      end

      parsing_context = ParsingContext.new
      reader = Reader.new(parsing_context)
      reader.instance_eval(IO.read(content_file_path))

      world = Demiurge.new.create_game(parsing_context)
      world.validate

       Writer.new.write_world(world)
    end

  end
end