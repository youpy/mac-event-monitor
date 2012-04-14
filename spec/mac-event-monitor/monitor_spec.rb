require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Mac::EventMonitor

describe Monitor do
  subject do
    Monitor.new
  end

  it 'should monitor mouse down events' do
    result = 0
    robot = Mac::Robot.new

    monitor = subject
    monitor.add_listener(:mouse_down) do |event|
      result += 1
    end

    result.should be_zero

    EM.run do
      [1, 1.5].each do |t|
        EM.add_timer(t) do
          robot.mouse_press
        end
      end

      EM.add_timer(2) do
        EM.stop
      end

      EM.add_periodic_timer(0.1) do
        monitor.run(0.1)
      end
    end

    result.should be >= 2
  end
end
