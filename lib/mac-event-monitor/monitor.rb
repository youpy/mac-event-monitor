module Mac
  module EventMonitor
    class Monitor
      def initialize
        @listeners     = {}
        @any_listeners = []
      end

      def add_listener(type = nil, &block)
        if type
          @listeners[type] ||= []
          @listeners[type] << block
        else
          @any_listeners << block
        end
      end

      def run(stop_after = nil)
        run_app(stop_after)
      end

      def receive_event(str, screen_height)
        event = Event.create_from_description(str, screen_height)

        (@listeners[event.type] || []).each do |block|
          block.call(event)
        end

        @any_listeners.each do |block|
          block.call(event)
        end
      end
    end
  end
end
