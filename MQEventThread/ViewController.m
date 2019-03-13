//
//  ViewController.m
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import "ViewController.h"
#import "QXShareEventQueue.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    QXShareEventQueue *queue = [QXShareEventQueue shareInstance];
    QXShareEventQueue *queue1 = [queue copy];
    QXShareEventQueue *queue2 = [queue mutableCopy];
    QXShareEventQueue *queue3 = [[QXShareEventQueue alloc] init];
    NSLog(@"%p\n%p\n\%p\n%p",queue,queue1,queue2,queue3);
}




@end
