#import "event_monitor.h"

@implementation EventMonitorAppDelegate

@synthesize rb_monitor;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSEventMask mask;

  mask =
      NSLeftMouseUpMask
    | NSRightMouseUpMask
    | NSOtherMouseUpMask
    | NSLeftMouseDownMask
    | NSRightMouseDownMask
    | NSOtherMouseDownMask
    | NSLeftMouseDraggedMask
    | NSRightMouseDraggedMask
    | NSOtherMouseDraggedMask
    | NSMouseMovedMask
    // | NSScrollWheelMask
    // | NSTabletPointMask
    // | NSTabletProximityMask
    // | NSKeyDownMask
    ;

  eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:mask
                                                        handler:^(NSEvent *incomingEvent) {
      VALUE event;

      event = rb_str_new2([[incomingEvent description] UTF8String]);
      rb_funcall(rb_monitor, rb_intern("receive_event"), 1, event);
    }];
}

- (void)onTimeout:(NSTimer *)timer {
  NSEvent *event;

  [[NSApplication sharedApplication] stop:nil];
  //[NSEvent removeMonitor:eventMonitor];

  // http://www.cocoabuilder.com/archive/cocoa/219842-nsapp-stop.html
  event = [NSEvent otherEventWithType: NSApplicationDefined
                                      location: NSMakePoint(0,0)
                                 modifierFlags: 0
                                     timestamp: 0.0
                                  windowNumber: 0
                                       context: nil
                                       subtype: 0
                                         data1: 0
                                         data2: 0];
  [NSApp postEvent: event atStart: true];
}

@end

static VALUE rb_cMonitor;

static VALUE cMonitor_run_app(int argc, VALUE *argv, VALUE self)
{
  EventMonitorAppDelegate *delegate;
  VALUE stopAfter;

  rb_scan_args(argc, argv, "1", &stopAfter);

  delegate = [EventMonitorAppDelegate new];
  delegate.rb_monitor = self;

  [NSApplication sharedApplication];
  [NSApp setDelegate: delegate];

  if(stopAfter) {
    [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)NUM2INT(stopAfter)
                                     target:delegate
                                   selector:@selector(onTimeout:)
                                   userInfo:nil
                                    repeats:NO];
  }

  [NSApp run];

  return Qnil;
}

void Init_event_monitor(void){
  VALUE rb_mMac, rb_mEventMonitor;

  rb_mMac = rb_define_module("Mac");
  rb_mEventMonitor = rb_define_module_under(rb_mMac, "EventMonitor");
  rb_cMonitor = rb_define_class_under(rb_mEventMonitor, "Monitor", rb_cObject);
  rb_define_method(rb_cMonitor, "run_app", cMonitor_run_app, -1);
}
