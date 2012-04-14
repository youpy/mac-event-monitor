#include <ruby.h>
#import <AppKit/AppKit.h>

@interface EventMonitorAppDelegate : NSObject <NSApplicationDelegate> {
  id eventMonitor;
}

-(void)onTimeout:(NSTimer *) timer;

@property (assign) VALUE rb_monitor;

@end

