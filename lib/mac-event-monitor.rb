require 'mac-event-monitor/version'
require 'event_monitor'

module Mac
  class EventMonitor
    def initialize
      add_global_monitor
    end

    def add_listener(type, &block)
    end

    def run(seconds)
    end
  end
end
