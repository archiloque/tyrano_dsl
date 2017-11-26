module TyranoDsl

  module Elements

    class Background

      attr_reader :name
      attr_reader :path

      def initialize(name, path)
        @name = name
        @path = path
      end

    end
  end

end