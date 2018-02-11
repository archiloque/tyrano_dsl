class TyranoDsl::ImportTyrano::Character

  # @return [String]
  attr_reader :name
  # @return [Integer]
  attr_reader :index
  # @return [Hash{Symbol=>String}]
  attr_accessor :stances

  def initialize(name, index)
    @name = name
    @index = index
    @stances = {}
  end

end