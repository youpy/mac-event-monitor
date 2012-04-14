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

@end

static VALUE rb_cMonitor;

static VALUE cMonitor_run_forever(int argc, VALUE *argv, VALUE self)
{
  EventMonitorAppDelegate *delegate;

  delegate = [EventMonitorAppDelegate new];
  delegate.rb_monitor = self;

  [NSApplication sharedApplication];
  [NSApp setDelegate: delegate];
  [NSApp run];

  return Qnil;
}

static VALUE cMonitor_stop(int argc, VALUE *argv, VALUE self)
{
  [NSApplication sharedApplication];
  [NSApp stop:nil];

  return Qnil;
}

void Init_event_monitor(void){
  VALUE rb_mMac, rb_mEventMonitor;

  rb_mMac = rb_define_module("Mac");
  rb_mEventMonitor = rb_define_module_under(rb_mMac, "EventMonitor");
  rb_cMonitor = rb_define_class_under(rb_mEventMonitor, "Monitor", rb_cObject);
  rb_define_method(rb_cMonitor, "stop", cMonitor_stop, -1);
  rb_define_method(rb_cMonitor, "run_forever", cMonitor_run_forever, -1);
}
