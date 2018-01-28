require_relative 'elements'
require_relative 'stance'

# A character
class TyranoDsl::Elements::Character

  # @return [String]
  attr_reader :name

  # @return [Hash{String => TyranoDsl::Elements::Stance}]
  attr_reader :stances

  # @return [TyranoDsl::Elements::Stance]
  attr_reader :default_stance

  # @param [String] name
  # @param [String] declared_stances
  def initialize(name, declared_stances)
    @name = name
    @stances = stances
    @stances = {}

    declared_stances.each_pair do |stance_name, stance_file|
      stance = TyranoDsl::Elements::Stance.new(
          stance_name,
          stance_file)
      @stances[stance_name] = stance

      if stance_name == :default
        @default_stance = stance
      end
    end
  end

end
