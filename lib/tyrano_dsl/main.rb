require_relative 'parser'
require_relative 'parsing_context'
require_relative 'tyrano_exception'
require_relative 'tyrano_dsl'
require_relative 'writer'

class TyranoDsl::Main

  # @param [String] file_path path to the DSL file
  # @return [TyranoDsl::WritingContext]
  def run(file_path)
    parsing_context = TyranoDsl::ParsingContext.new
    parser = TyranoDsl::Parser.new(parsing_context, file_path)
    parser.include_file(file_path)
    TyranoDsl::Writer.new.write(parsing_context.world, parsing_context.words)
  end

end