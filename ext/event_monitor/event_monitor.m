#import "event_monitor.h"

NSEventMask mask =
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
  | NSKeyDownMask
  | NSKeyUpMask
  // | NSScrollWheelMask
  // | NSTabletPointMask
  // | NSTabletProximityMask
  ;

@implementation EventMonitorAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [NSEvent addGlobalMonitorForEventsMatchingMask:mask
                                         handler:^(NSEvent *incomingEvent) {}];
}

- (void)onTimeout:(NSTimer *)timer {
  NSEvent *event;

  [NSEvent removeMonitor:[timer userInfo]];
  [timer release];

  [[NSApplication sharedApplication] stop:nil];

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
  id eventMonitor;

  rb_scan_args(argc, argv, "1", &stopAfter);

  if(!(delegate = [[NSApplication sharedApplication] delegate])) {
    delegate = [[EventMonitorAppDelegate alloc] init];
    [NSApp setDelegate: delegate];
  }

  eventMonitor = [NSEvent addGlobalMonitorForEventsMatchingMask:mask
                                                        handler:^(NSEvent *incomingEvent) {
      rb_funcall(self, rb_intern("receive_event"), 1, rb_str_new2([[incomingEvent description] UTF8String]));
    }];

  if(stopAfter != Qnil) {
    [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)NUM2INT(stopAfter)
                                     target:delegate
                                   selector:@selector(onTimeout:)
                                   userInfo:eventMonitor
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
