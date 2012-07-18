require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include Mac::EventMonitor

describe Event do
  it 'should create event from description' do
    event = Event.create_from_description('NSEvent: type=LMouseDown loc=(618,524) time=1136789.4 flags=0x100 win=0x0 winNum=17310 ctxt=0x0 evNum=14883 click=1 buttonNumber=0 pressure=1')

    event.should be_an_instance_of(MouseEvent)
    event.type.should equal(:mouse_down)
    event.button.should equal(:left)
    event.location.x.should be_an_instance_of(Float)
    event.location.y.should be_an_instance_of(Float)
  end

  it 'should create event from description with space' do
    event = Event.create_from_description('NSEvent: type=KeyDown loc=(184,646) time=68067.5 flags=0x20104 win=0x0 winNum=0 ctxt=0x0 chars=" " unmodchars=" " repeat=0 keyCode=49')

    event.should be_an_instance_of(KeyboardEvent)
    event.type.should equal(:key_down)
    event.keycode.should equal(49)
    event.shift_key?.should be_true
  end
end
