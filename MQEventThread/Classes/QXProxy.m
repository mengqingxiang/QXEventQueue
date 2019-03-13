//
//  QXProxy.m
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import "QXProxy.h"

@interface QXProxy()
@property(nonatomic,weak)id target;
@end

@implementation QXProxy

+(instancetype)instanceWithTarget:(id)target {
    QXProxy *proxy = [QXProxy alloc];
    proxy.target = target;
    return proxy;
}


-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel{
    return [self.target methodSignatureForSelector:sel];
}


-(void)forwardInvocation:(NSInvocation *)invocation{
    [invocation invokeWithTarget:self.target];
}


@end
