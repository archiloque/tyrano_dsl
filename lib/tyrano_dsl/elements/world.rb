module TyranoDsl

  module Elements

    # A declared world
    # @attr [Hash{String => TyranoDsl::Elements::Scene}] scenes
    # @attr [Hash{String => TyranoDsl::Elements::Character}] characters
    # @attr [Hash{String => TyranoDsl::Elements::Background}] backgrounds
    class World

      attr_reader :scenes, :characters, :backgrounds

      def initialize(file_path)
        @scenes = {}
        @characters = {}
        @backgrounds = {}
        @file_path = file_path
      end

      def inspect
        "[#{@file_path}] #{scenes.length} scenes: #{scenes.values.collect {|s| "[#{s.name}]"}.join(', ')} #{characters.length} characters: #{characters.values.collect {|c| "[#{c.name}]"}.join(', ')} #{backgrounds.length} backgrounds: #{backgrounds.values.collect {|b| "[#{b.name}]"}.join(', ')}"
      end
    end

  end
end