module Mac
  module EventMonitor
    class Location
      include JsonSerializable

      attr_accessor :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end

      def data
        [x, y]
      end
    end
  end
end
