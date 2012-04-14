require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Mac::EventMonitor do
  subject do
    Mac::EventMonitor.new
  end

  it 'should monitor mouse down events' do
    monitor = subject
    result = false

    result.should_not be_true

    EM.run {
      EM.add_timer(2) do
        robot = Mac::Robot.new
        robot.mouse_press
      end

      EM.add_timer(5) do
        EM.stop
      end

      EM.add_periodic_timer(1) do
        monitor.run(0.1)
      end

      monitor.add_listener(:mouse_down) do |event|
        result = true
      end
    }

    result.should be_true
  end
end
