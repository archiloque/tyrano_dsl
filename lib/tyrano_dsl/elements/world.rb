require_relative 'title_screen'

module TyranoDsl

  module Elements

    # A declared world
    # @attr [Hash{String => TyranoDsl::Elements::Scene}] scenes
    # @attr [Hash{String => TyranoDsl::Elements::Character}] characters
    # @attr [Hash{String => TyranoDsl::Elements::Background}] backgrounds
    # @attr [TyranoDsl::Elements::TitleScreen] title_screen
    # @attr [Array<TyranoDsl::Elements::JumpTarget>] jump_targets
    class World

      attr_reader :scenes, :characters, :backgrounds, :title_screen, :jump_targets

      def initialize(file_path)
        @scenes = {}
        @characters = {}
        @backgrounds = {}
        @jump_targets = []
        @file_path = file_path
        @title_screen = TyranoDsl::Elements::TitleScreen.new
      end

      # @return [void]
      # @raise [TyranoDsl::TyranoException]
      def validate
        @jump_targets.each do |jump_target|
          scene = @scenes[jump_target.scene]
          unless scene
            raise TyranoDsl::TyranoException, "Unknown scene [#{jump_target.scene}] declared in label"
          end
          if jump_target.label && (!scene.labels.include?(jump_target.label))
            raise TyranoDsl::TyranoException, "Unknown label [#{jump_target.label}] declared in label"
          end
        end
      end

      def inspect
        "[#{@file_path}] #{scenes.length} scenes: #{scenes.values.collect {|s| "[#{s.name}]"}.join(', ')} #{characters.length} characters: #{characters.values.collect {|c| "[#{c.name}]"}.join(', ')} #{backgrounds.length} backgrounds: #{backgrounds.values.collect {|b| "[#{b.name}]"}.join(', ')}"
      end
    end

  end
end