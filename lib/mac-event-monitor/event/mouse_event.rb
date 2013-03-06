module Mac
  module EventMonitor
    class MouseEvent < Event
      attr_reader :button

      def initialize(type, location, button)
        super(type, location)

        @button = button
      end
    end
  end
end
