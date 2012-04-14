#import "event_monitor.h"

static VALUE rb_cEventMonitor;

struct EventMonitorObject {};

void cEventMonitor_free(void *ptr) {
  free(ptr);
}

VALUE createInstance() {
  struct EventMonitorObject *obj;

  obj = malloc(sizeof(struct EventMonitorObject));

  return Data_Wrap_Struct(rb_cEventMonitor, 0, cEventMonitor_free, obj);
}

static VALUE cEventMonitor_add_global_monitor(int argc, VALUE *argv, VALUE self)
{
  [NSEvent addGlobalMonitorForEventsMatchingMask:(NSLeftMouseDownMask)
                                         handler:^(NSEvent *incomingEvent) {
      //NSWindow *targetWindowForEvent = [incomingEvent window];
      NSLog(@"Got a mouse click event at %@", NSStringFromPoint([incomingEvent locationInWindow]));
    }];

  return Qnil;
}

static VALUE cEventMonitor_run_forever(int argc, VALUE *argv, VALUE self)
{
  [[NSRunLoop currentRunLoop] run];

  return Qnil;
}

void Init_event_monitor(void){
  VALUE rb_mMac;

  rb_mMac = rb_define_module("Mac");
  rb_cEventMonitor = rb_define_class_under(rb_mMac, "EventMonitor", rb_cObject);
  rb_define_method(rb_cEventMonitor, "add_global_monitor", cEventMonitor_add_global_monitor, -1);
  rb_define_method(rb_cEventMonitor, "run_loop", cEventMonitor_run_forever, -1);
}
