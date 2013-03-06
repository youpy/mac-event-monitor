require 'json'

module Mac
  module EventMonitor
    module JsonSerializable
      def self.included(klass)
        klass.instance_eval do
          def json_create(o)
            new(*o['data'])
          end
        end
      end

      def to_json(*a)
        {
          'json_class' => self.class.name,
          'data'       => data
        }.to_json(*a)
      end
    end
  end
end
