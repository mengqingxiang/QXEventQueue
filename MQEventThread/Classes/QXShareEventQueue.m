//
//  QXShareEventQueue.m
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import "QXShareEventQueue.h"

@implementation QXShareEventQueue
static QXShareEventQueue *__shareInstance=nil;

+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __shareInstance = [[super allocWithZone:NULL] init];
    });
    return __shareInstance;
}


-(void)executeTaskWithBlock:(QXEventBlock)task{
    [__shareInstance executeTaskWithBlock:task];
}

-(void)executeTaskWithTargret:(id)target action:(SEL)action{
    [__shareInstance executeTaskWithTargret:target action:action];
}

-(void)stop{
    [__shareInstance stop];
}


+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [QXShareEventQueue shareInstance];
}

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}
@end
