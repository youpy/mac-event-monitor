#include <ruby.h>
#import <AppKit/AppKit.h>

@interface EventMonitorAppDelegate : NSObject <NSApplicationDelegate> {
  id eventMonitor;
}

@property (assign) VALUE rb_monitor;

@end

