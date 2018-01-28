require_relative 'elements'

# A background
class TyranoDsl::Elements::Background

  # @return [String]
  attr_reader :name

  # @return [String]
  attr_reader :image_path

  # @param [String] name
  # @param [String] image_path
  def initialize(name, image_path)
    @name = name
    @image_path = image_path
  end

end
