module Mac
  module EventMonitor
    class KeyboardEvent < Event
      attr_reader :keycode, :flags

      def initialize(type, location, keycode, flags)
        super(type, location)

        @keycode = keycode.to_i
        @flags   = flags.to_i(16)
      end

      def shift_key?
        check_flag(16) || check_flag(17)
      end

      def ctrl_key?
        check_flag(18)
      end

      def alt_key?
        check_flag(19)
      end

      def command_key?
        check_flag(20)
      end

      def num_pad_key?
        check_flag(21)
      end

      def help_key?
        check_flag(22)
      end

      def function_key?
        check_flag(23)
      end

      private

      def check_flag(shift)
        !(flags & (1 << shift)).zero?
      end
    end
  end
end
