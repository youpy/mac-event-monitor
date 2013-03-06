require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'json'

include Mac::EventMonitor

describe Event do
  describe '.create_from_description' do
    it 'should create event from description' do
      event = Event.create_from_description('NSEvent: type=LMouseDown loc=(618,524) time=1136789.4 flags=0x100 win=0x0 winNum=17310 ctxt=0x0 evNum=14883 click=1 buttonNumber=0 pressure=1', 1136789.5, 768)

      event.should be_an_instance_of(MouseEvent)
      event.type.should equal(:mouse_down)
      event.button.should equal(:left)
      event.location.x.should eql(618.0)
      event.location.y.should eql(244.0)
      event.time.should eql(1136789.5)
    end

    it 'should create event from description with space' do
      event = Event.create_from_description('NSEvent: type=KeyDown loc=(184,646) time=68067.5 flags=0x20104 win=0x0 winNum=0 ctxt=0x0 chars=" " unmodchars=" " repeat=0 keyCode=49', 68067.6, 768)

      event.should be_an_instance_of(KeyboardEvent)
      event.type.should equal(:key_down)
      event.keycode.should equal(49)
      event.shift_key?.should be_true
      event.location.x.should eql(184.0)
      event.location.y.should eql(122.0)
      event.time.should eql(68067.6)
    end
  end

  describe '#to_json' do
    it 'serializes mouse event to json' do
      event = Event.create_from_description('NSEvent: type=LMouseDown loc=(618,524) time=1136789.4 flags=0x100 win=0x0 winNum=17310 ctxt=0x0 evNum=14883 click=1 buttonNumber=0 pressure=1', 1136789.44, 768)
      event = JSON.parse(event.to_json)

      event.should be_an_instance_of(MouseEvent)
      event.type.should equal(:mouse_down)
      event.button.should equal(:left)
      event.location.x.should eql(618.0)
      event.location.y.should eql(244.0)
      event.time.should eql(1136789.44)
    end

    it 'serializes mouse event to json' do
      event = Event.create_from_description('NSEvent: type=KeyDown loc=(184,646) time=68067.5 flags=0x20104 win=0x0 winNum=0 ctxt=0x0 chars=" " unmodchars=" " repeat=0 keyCode=49', 68067.55, 768)
      event = JSON.parse(event.to_json)

      event.should be_an_instance_of(KeyboardEvent)
      event.type.should equal(:key_down)
      event.keycode.should equal(49)
      event.shift_key?.should be_true
      event.location.x.should eql(184.0)
      event.location.y.should eql(122.0)
      event.time.should eql(68067.55)
    end
  end
end
