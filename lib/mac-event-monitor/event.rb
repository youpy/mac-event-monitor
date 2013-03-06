module Mac
  module EventMonitor
    class Event
      include JsonSerializable

      attr_reader :type, :time, :location

      class << self
        def create_from_description(description, screen_height)
          _, *atts_as_string = description.split(/ +/)

          attrs = (atts_as_string.join(' ') + ' ').scan(/([^=]+)=([^=]+) (?=\w?)/).inject({}) do |result, pair|
            name, value = pair
            result[name.to_sym] = value
            result
          end

          location = parse_location(attrs[:loc])
          location.y = screen_height - location.y

          time = attrs[:time].to_f

          case attrs[:type]
          when 'LMouseUp'
            MouseEvent.new(:mouse_up,    time, location, :left)
          when 'RMouseUp'
            MouseEvent.new(:mouse_up,    time, location, :right)
          when 'OMouseUp'
            MouseEvent.new(:mouse_up,    time, location, :other)
          when 'LMouseDown'
            MouseEvent.new(:mouse_down,  time, location, :left)
          when 'RMouseDown'
            MouseEvent.new(:mouse_down,  time, location, :right)
          when 'OMouseDown'
            MouseEvent.new(:mouse_down,  time, location, :other)
          when 'MouseMoved'
            MouseEvent.new(:mouse_move,  time, location, nil)
          when 'LMouseDragged'
            MouseEvent.new(:mouse_drag,  time, location, :left)
          when 'RMouseDragged'
            MouseEvent.new(:mouse_drag,  time, location, :right)
          when 'OMouseDragged'
            MouseEvent.new(:mouse_drag,  time, location, :other)
          when 'KeyDown'
            KeyboardEvent.new(:key_down, time, location, attrs[:keyCode], attrs[:flags])
          when 'KeyUp'
            KeyboardEvent.new(:key_up,   time, location, attrs[:keyCode], attrs[:flags])
          end
        end

        def parse_location(location_as_str)
          Location.new(*location_as_str.scan(/[\d\.]+/).map {|v| v.to_f })
        end
      end

      def initialize(type, time, location)
        @type     = type.to_sym
        @time     = time
        @location = location
      end

      def data
        [type, time, location]
      end
    end
  end
end
