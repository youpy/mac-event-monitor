module Mac
  module EventMonitor
    class Monitor
      def initialize
        @listeners = {}
      end

      def add_listener(type, &block)
        @listeners[type] ||= []
        @listeners[type] << block
      end

      def run
        run_forever
      end

      def receive_event(str)
        event = Event.create_from_description(str)

        (@listeners[event.type] || []).each do |block|
          block.call(event)
        end
      end
    end
  end
end
