require_relative 'elements_module'
require_relative 'stance'

# A character
class TyranoDsl::Elements::Character

  CHARACTER_DIRECTORY = File.join('data', 'fgimage', 'chara')

  # @return [String]
  attr_reader :name
  # @return [Index]
  attr_reader :index
  # @return [Hash{String => TyranoDsl::Elements::Stance}]
  attr_reader :stances
  # @return [TyranoDsl::Elements::Stance]
  attr_reader :default_stance

  # @param [String] name
  # @param [String] declared_stances
  # @param [Integer] index
  def initialize(name, declared_stances, index)
    @name = name
    @stances = stances
    @index = index
    @stances = {}

    @stances_target_long_files_names = {}
    @stance_target_short_file_names = {}
    declared_stances.each_pair do |stance_name, stance_file|
      short_file_name = File.join(index.to_s,
                                  "#{@stances.length}#{File.extname(stance_file)}")
      long_file_name = File.join(
          CHARACTER_DIRECTORY, short_file_name)
      stance = TyranoDsl::Elements::Stance.new(
          stance_name,
          stance_file,
          short_file_name,
          long_file_name)
      @stances[stance_name] = stance

      if stance_name == :default
        @default_stance = stance
        @default_stance_target_short_file_name = short_file_name
      end
    end
  end

end
