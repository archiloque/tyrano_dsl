require_relative 'elements_module'

# A background
class TyranoDsl::Elements::Background

  # @return [String]
  attr_reader :name
  # @return [String]
  attr_reader :image_path
  # @return [String]
  attr_reader :target_short_file_name
  # @return [String]
  attr_reader :target_long_file_name

  BACKGROUND_DIRECTORY = File.join('data', 'bgimage')

  # @param [String] name
  # @param [String] image_path
  # @param [Integer] index
  def initialize(name, image_path, index)
    @name = name
    @image_path = image_path
    @index = index
    @target_short_file_name = "#{index}#{File.extname(image_path)}"
    @target_long_file_name = File.join(
        BACKGROUND_DIRECTORY,
        @target_short_file_name
    )
  end

end
