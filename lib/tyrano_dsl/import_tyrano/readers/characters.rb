require 'json'

require_relative '../../parsed_word'
require_relative '../../tyrano_constants'
require_relative '../character'
require_relative 'base_reader'

# Read characters declaration
class TyranoDsl::ImportTyrano::Readers::Characters < TyranoDsl::ImportTyrano::Readers::BaseReader

  # @param [TyranoDsl::ImportTyrano::FileAccessor] file_accessor
  # @return [Array<TyranoDsl::ImportTyrano::Character>]
  def read(file_accessor)
    log {"Reading characters definitions from #{File.join(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE)}"}

    characters = {}

    parsed_file = JSON.parse(file_accessor.read_file(TyranoDsl::TyranoConstants::BUILDER_CONFIG_FILE))
    parsed_file[TyranoDsl::TyranoConstants::BUILDER_CONFIG_CHARACTERS_PATH].each_pair do |name, value|
      characters[name] = TyranoDsl::ImportTyrano::Character.new(name, value)
    end

    log {"Reading default stances from #{File.join(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE)}"}
    file_accessor.read_file(TyranoDsl::TyranoConstants::CHARA_DEFINE_FILE).each_line do |line|
      if (match = line.match(/\A\[chara_new\s+name="(?<name>[^"]+)"\s+jname="(?<jname>[^"]+)"\s+storage="(?<storage>[^"]+)"\s+\]/))
        character_name = match[:name]
        unless characters.key?(character_name)
          characters[character_name] = TyranoDsl::ImportTyrano::Character.new(character_name, -1)
        end
        characters[character_name].stances[:default] = match[:storage]
      end
    end

    characters.values
  end

end
