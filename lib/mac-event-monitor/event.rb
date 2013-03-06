module Mac
  module EventMonitor
    class Event
      attr_reader :type, :location

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

          case attrs[:type]
          when 'LMouseUp'
            MouseEvent.new(:mouse_up,    location, :left)
          when 'RMouseUp'
            MouseEvent.new(:mouse_up,    location, :right)
          when 'OMouseUp'
            MouseEvent.new(:mouse_up,    location, :other)
          when 'LMouseDown'
            MouseEvent.new(:mouse_down,  location, :left)
          when 'RMouseDown'
            MouseEvent.new(:mouse_down,  location, :right)
          when 'OMouseDown'
            MouseEvent.new(:mouse_down,  location, :other)
          when 'MouseMoved'
            MouseEvent.new(:mouse_move,  location, nil)
          when 'LMouseDragged'
            MouseEvent.new(:mouse_drag,  location, :left)
          when 'RMouseDragged'
            MouseEvent.new(:mouse_drag,  location, :right)
          when 'OMouseDragged'
            MouseEvent.new(:mouse_drag,  location, :other)
          when 'KeyDown'
            KeyboardEvent.new(:key_down, location, attrs[:keyCode], attrs[:flags])
          when 'KeyUp'
            KeyboardEvent.new(:key_up,   location, attrs[:keyCode], attrs[:flags])
          end
        end

        def parse_location(location_as_str)
          Struct.new(:x, :y).new(*location_as_str.scan(/[\d\.]+/).map {|v| v.to_f })
        end
      end

      def initialize(type, location)
        @type     = type
        @location = location
      end
    end
  end
end
