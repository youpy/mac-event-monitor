module Mac
  module EventMonitor
    class MouseEvent < Event
      attr_reader :location, :button

      def initialize(type, location_as_str, button)
        super(type)

        @location = parse_location(location_as_str)
        @button = button
      end

      private

      def parse_location(location_as_str)
        Struct.new(:x, :y).new(*location_as_str.scan(/[\d\.]+/).map {|v| v.to_f })
      end
    end
  end
end
