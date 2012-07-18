# mac-event-monitor

A Library to Monitor User Interactions

## Installation

    $ gem install mac-event-monitor

## Usage

    require 'mac-event-monitor'
    
    monitor = Mac::EventMonitor::Monitor.new

### Monitor Mouse Event

    monitor.add_listener(:mouse_down) do |event|
      puts [event.location.x, event.location.y].join(',')
    end
    monitor.run

### Monitor Keyboard Event

You need to enable "Access to assistive devices" in the Universal Access preference pane to monitor keyboard event.

    monitor.add_listener(:key_down) do |event|
      p event.keycode
      p event.shift_key?
    end
    monitor.run

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
