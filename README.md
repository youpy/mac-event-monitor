# mac-event-monitor

A Library to Monitor User Interaction

## Installation

 $ gem install mac-event-monitor

## Usage

 require 'mac-event-monitor'

 monitor = Mac::EventMonitor::Monitor.new
 monitor.add_listener(:mouse_down) do |event|
   puts [event.location.x, event.location.y].join(',')
 end
 monitor.run

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
