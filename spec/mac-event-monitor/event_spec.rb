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
end
