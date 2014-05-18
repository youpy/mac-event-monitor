require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Mac::EventMonitor::Monitor do
  before do
    @monitor = Mac::EventMonitor::Monitor.new
  end

  it 'should monitor mouse down events' do
    result = 0
    robot = Mac::Robot.new

    @monitor.add_listener(:mouse_down) do |event|
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
        @monitor.run(0.1)
      end
    end

    result.should be >= 2
  end

  it 'should monitor key down events' do
    result = 0
    robot = Mac::Robot.new

    @monitor.add_listener(:key_down) do |event|
      result += 1
    end

    result.should be_zero

    EM.run do
      [1, 1.5].each do |t|
        EM.add_timer(t) do
          robot.key_press(0x04)
        end
      end

      EM.add_timer(2) do
        EM.stop
      end

      EM.add_periodic_timer(0.1) do
        @monitor.run(0.1)
      end
    end

    result.should be >= 2
  end

  it 'should monitor all' do
    result = 0
    robot = Mac::Robot.new

    @monitor.add_listener do |event|
      result += 1
    end

    result.should be_zero

    EM.run do
      [1, 1.5].each do |t|
        EM.add_timer(t) do
          robot.mouse_press
        end
      end

      [2, 2.5].each do |t|
        EM.add_timer(t) do
          robot.key_press(0x04)
        end
      end

      EM.add_timer(3) do
        EM.stop
      end

      EM.add_periodic_timer(0.1) do
        @monitor.run(0.1)
      end
    end

    result.should be >= 4
  end
end
