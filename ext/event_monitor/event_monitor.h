#include <ruby.h>
#import <AppKit/AppKit.h>

@interface EventMonitorAppDelegate : NSObject <NSApplicationDelegate> {
}

-(void)onTimeout:(NSTimer *) timer;

@end

NSEventMask mask;
