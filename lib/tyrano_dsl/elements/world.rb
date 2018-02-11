require_relative 'elements'
require_relative 'title_screen'
require_relative 'variable'

# The game world
class TyranoDsl::Elements::World

  # @return [Hash{String => TyranoDsl::Elements::Background}]
  attr_reader :backgrounds

  # @return [Hash{String => TyranoDsl::Elements::Character}]
  attr_reader :characters

  # @return [Array<TyranoDsl::Elements::JumpTarget>]
  attr_reader :jump_targets

  # @return [Hash{String => TyranoDsl::Elements::Scene}]
  attr_reader :scenes

  # @return [TyranoDsl::Elements::TitleScreen]
  attr_reader :title_screen

  # @return [Hash{String => TyranoDsl::Elements::Variable}]
  attr_reader :variables

  def initialize
    @characters = {}
    @backgrounds = {}
    @jump_targets = []
    @scenes = {}
    @variables = {}
    @title_screen = TyranoDsl::Elements::TitleScreen.new
  end

  # @return [void]
  # @raise [TyranoDsl::TyranoException]
  def validate
    @jump_targets.each do |jump_target|
      scene = @scenes[jump_target.scene]
      unless scene
        TyranoDsl::TyranoException.raise_exception "Unknown scene [#{jump_target.scene}] declared in label", jump_target.word_location
      end
      jump_target_label = jump_target.label
      if jump_target_label && (!scene.labels.include?(jump_target_label))
        TyranoDsl::TyranoException.raise_exception "Unknown label [#{jump_target_label}] for scene [#{jump_target.scene}] declared in label", jump_target.word_location
      end
    end
  end

end
