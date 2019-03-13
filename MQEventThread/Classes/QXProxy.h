//
//  QXProxy.h
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QXProxy : NSProxy
+(instancetype)instanceWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
