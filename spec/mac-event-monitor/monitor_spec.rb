require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Mac::EventMonitor

describe Monitor do
  subject do
    Monitor.new
  end

  it 'should monitor mouse down events' do
    pending 'how to test?'

    monitor = subject
    result = false

    monitor.add_listener(:mouse_down) do |event|
      result = true
    end

    result.should_not be_true

    monitor.run

    result.should be_true
  end
end
