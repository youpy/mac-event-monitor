module Mac
  module EventMonitor
    class MouseEvent < Event
      attr_reader :button

      def initialize(type, time, location, button)
        super(type, time, location)

        @button = button && button.to_sym
      end

      def data
        super + [button]
      end
    end
  end
end
