//
//  MQEventThread.m
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import "QXEventQueue.h"


//-----------------------MQThread-------------------
@interface QXThread : NSThread

@end

@implementation QXThread
-(void)dealloc {
    NSLog(@"%s",__func__);
}
@end


//-----------------------MQEventThread-------------------
@interface QXEventQueue()
@property(nonatomic,strong)QXThread *innerThread;
@end


@implementation QXEventQueue

#pragma mark - public method
- (instancetype)init
{
    if (self = [super init]) {
        self.innerThread = [[QXThread alloc] initWithTarget:self selector:@selector(__setupThread) object:nil];
        self.innerThread.name = @"com.mengqingxiang.eventThread";
        [self.innerThread start];
    }
    return self;
}



- (void)executeTaskWithBlock:(QXEventBlock)task{
    if (!self.innerThread || !task) { return; }
    [self performSelector:@selector(__executeTask:) onThread:self.innerThread withObject:task waitUntilDone:false];
}

-(void)executeTaskWithTargret:(id)target action:(SEL)action{
    if (self.innerThread && target && [target respondsToSelector:action]) {
        [target performSelector:action onThread:self.innerThread withObject:nil waitUntilDone:false];
    }
}



-(void)stop{
    if (!self.innerThread) { return; }
    [self performSelector:@selector(__stop) onThread:self.innerThread withObject:nil waitUntilDone:YES];
}


#pragma mark - private method
-(void)__setupThread {
    
    CFRunLoopObserverRef ref = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopAllActivities, true, 0, runLoopObserverCallBack, NULL);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), ref, kCFRunLoopDefaultMode);
    CFRelease(ref);
    
    CFRunLoopSourceContext context = { 0 };
    CFRunLoopSourceRef source = CFRunLoopSourceCreate(CFAllocatorGetDefault(), 0, &context);
    CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    CFRelease(source);
    
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
    
}


void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"kCFRunLoopEntry");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"kCFRunLoopBeforeTimers");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"kCFRunLoopBeforeSources");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"kCFRunLoopBeforeWaiting");
            break;
        default:
            break;
    }
}


-(void)__stop{
    CFRunLoopStop(CFRunLoopGetCurrent());
    self.innerThread = nil;
}

-(void)__executeTask:(QXEventBlock)task {
    
    if (task) {
        task();
    }
}


-(void)dealloc{
    [self stop];
    NSLog(@"%s",__func__);
}




@end
