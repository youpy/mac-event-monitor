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

### Record/Play Events

```
$ ruby recorder.rb | ruby player.rb
```

recorder.rb

```ruby
require 'mac-event-monitor'
require 'json'

e = Mac::EventMonitor::Monitor.new
events = []
e.add_listener {|e|
  events << e
}
e.run(3)

puts events.to_json
```

player.rb

```ruby
require 'mac-event-monitor'
require 'mac-robot'
require 'json'

events = JSON.parse(ARGF.read)
robot = Mac::Robot.new

events.each_with_index do |event, index|
  case event.type
  when :mouse_move
    robot.mouse_move(event.location.x, event.location.y)
  when :mouse_drag
    robot.mouse_drag(event.location.x, event.location.y)
  when :mouse_down
    robot.mouse_press
  when :mouse_up
    robot.mouse_release
  when :key_down
    robot.key_press(event.keycode)
  when :key_up
    robot.key_release(event.keycode)
  end

  if n = events[index + 1]
    sleep n.time - event.time
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
