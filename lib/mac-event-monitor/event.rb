module Mac
  module EventMonitor
    class Event
      attr_reader :type

      class << self
        def create_from_description(description)
          _, *atts_as_string = description.split(/ +/)

          attrs = (atts_as_string.join(' ') + ' ').scan(/([^=]+)=([^=]+) (?=\w?)/).inject({}) do |result, pair|
            name, value = pair
            result[name.to_sym] = value
            result
          end

          case attrs[:type]
          when 'LMouseUp'
            MouseEvent.new(:mouse_up, attrs[:loc], :left)
          when 'RMouseUp'
            MouseEvent.new(:mouse_up, attrs[:loc], :right)
          when 'OMouseUp'
            MouseEvent.new(:mouse_up, attrs[:loc], :other)
          when 'LMouseDown'
            MouseEvent.new(:mouse_down, attrs[:loc], :left)
          when 'RMouseDown'
            MouseEvent.new(:mouse_down, attrs[:loc], :right)
          when 'OMouseDown'
            MouseEvent.new(:mouse_down, attrs[:loc], :other)
          when 'MouseMoved'
            MouseEvent.new(:mouse_move, attrs[:loc], nil)
          when 'LMouseDragged'
            MouseEvent.new(:mouse_drag, attrs[:loc], :left)
          when 'RMouseDragged'
            MouseEvent.new(:mouse_drag, attrs[:loc], :right)
          when 'OMouseDragged'
            MouseEvent.new(:mouse_drag, attrs[:loc], :other)
          when 'KeyDown'
            KeyboardEvent.new(:key_down, attrs[:keyCode], attrs[:flags])
          when 'KeyUp'
            KeyboardEvent.new(:key_up, attrs[:keyCode], attrs[:flags])
          end
        end
      end

      def initialize(type)
        @type = type
      end
    end
  end
end
