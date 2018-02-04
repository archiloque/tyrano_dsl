require 'json'

require_relative '../../parsed_word'
require_relative '../../tyrano_constants'
require_relative 'base_reader'

# Read variables
class TyranoDsl::ImportTyrano::Readers::Characters < TyranoDsl::ImportTyrano::Readers::BaseReader

  # @param [TyranoDsl::ImportTyrano::Context] context
  # @param [TyranoDsl::ImportTyrano::FileAccessor] file_accessor
  # @return [nil]
  def read(file_accessor, context)
    log {"Reading characters definitions from #{File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE)}"}

    characters = {}

    parsed_file = JSON.parse(file_accessor.read_file(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE))
    parsed_file[TyranoDsl::TyranoConstants::BUILDER_CONFIG_CHARACTERS_PATH].each_pair do |name, value|
      characters[name] = TyranoDsl::ImportTyrano::Readers::Characters::Character.new(name, value)
    end

    log {"Reading default stances from #{File.join(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE)}"}
    file_accessor.read_file(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE).each_line do |line|
      if (match = line.match(/\A\[chara_new\s+name="(?<name>[^"]+)"\s+jname="(?<jname>[^"]+)"\s+storage="(?<storage>[^"]+)"\s+\]/))
        character_name = match[:name]
        unless characters.key?(character_name)
          characters[character_name] = TyranoDsl::ImportTyrano::Readers::Characters::Character.new(character_name, -1)
        end
        characters[character_name].default_stance_file_path = match[:storage]
      end
    end

    characters.values.collect do |character|
      TyranoDsl::ParsedWord.new(
          TyranoDsl::Vocabulary::DECLARE_CHARACTER,
          [],
          character_name: character.name,
          stances: {default: context.file_full_path(File.join(TyranoDsl::TyranoConstants::CHARACTER_IMAGE_DIRECTORY, character.default_stance_file_path))},
          )
    end
  end

  class Character

    # @return [String]
    attr_reader :name
    # @return [Integer]
    attr_reader :index
    # @return [String]
    attr_accessor :default_stance_file_path

    def initialize(name, index)
      @name = name
      @index = index
    end


  end
end
