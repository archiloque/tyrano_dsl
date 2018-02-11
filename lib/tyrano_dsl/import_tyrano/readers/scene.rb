require_relative '../../tyrano_constants'
require_relative '../../tyrano_exception'
require_relative '../../vocabulary'
require_relative 'base_reader'

# Read scenes
class TyranoDsl::ImportTyrano::Readers::Scene < TyranoDsl::ImportTyrano::Readers::BaseReader

  def initialize
    @words = []
    TyranoDsl::Vocabulary.get_words_class('import_tyrano/words') do |word, word_class|
      @words << word_class.new
    end

  end

  # @param [TyranoDsl::ImportTyrano::FileAccessor] file_accessor
  # @param [String] scene_name
  # @return [Array<TyranoDsl::ParsedWord>]
  # @param [TyranoDsl::ImportTyrano::Context] context
  def read(file_accessor, scene_name, context)
    scene_file = File.join(* TyranoDsl::TyranoConstants::SCENE_DIRECTORY + ["#{scene_name}.ks"])
    log {"Reading scene from #{scene_file}"}
    content = file_accessor.read_lines(TyranoDsl::TyranoConstants::SCENE_DIRECTORY + ["#{scene_name}.ks"])
    if content[0] != "[_tb_system_call storage=system/_#{scene_name}.ks]\n"
      raise TyranoDsl::TyranoException, "Error in line 0 of #{scene_file}"
    end
    context.current_scene_file = scene_file
    context.current_scene_content = content
    context.current_scene_line_index = 1
    context.current_scene_words = []
    context.add_parsed_word(
        TyranoDsl::Vocabulary::START_SCENE,
        {scene_name: scene_name}
    )
    while context.current_scene_line_index <= (context.current_scene_content.length - 1)
      unless try_parsing_next_line(context)
        warn{"Can't parse line #{context.current_scene_line_index} of [#{scene_file}]: [#{content[context.current_scene_line_index]}]"}
        context.go_next_line
      end
    end
    context.current_scene_file = nil
    context.current_scene_content = nil
    context.current_scene_line_index = nil
    result = context.current_scene_words
    context.current_scene_words = nil
    result
  end

  # @param [TyranoDsl::ImportTyrano::Context] context
  # @return [TrueClass]
  def try_parsing_next_line(context)
    next_line = context.current_line
    if next_line == "\n"
      context.go_next_line
       true
    else
    ! @words.index do |word|
      word.try_parsing(context)
    end.nil?
      end
  end


end
