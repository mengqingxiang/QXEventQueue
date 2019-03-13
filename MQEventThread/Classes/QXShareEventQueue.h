//
//  QXShareEventQueue.h
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QXEventQueue.h"
NS_ASSUME_NONNULL_BEGIN

@interface QXShareEventQueue : NSObject<NSCopying,NSMutableCopying>

+(instancetype)shareInstance;

-(void)executeTaskWithBlock:(QXEventBlock)task;

-(void)executeTaskWithTargret:(id)target action:(SEL)action;

-(void)stop;
@end

NS_ASSUME_NONNULL_END
