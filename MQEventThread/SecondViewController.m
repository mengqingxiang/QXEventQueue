//
//  SecondViewController.m
//  MQEventThread
//
//  Created by 孟庆祥 on 2019/3/13.
//  Copyright © 2019 孟庆祥. All rights reserved.
//

#import "SecondViewController.h"
#import "QXEventQueue.h"
#import "Person.h"
#import <objc/runtime.h>



@interface SecondViewController ()
@property(nonatomic,strong)QXEventQueue *eventQueue;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eventQueue = [[QXEventQueue alloc] init];
    NSLog(@"count---%@",[_eventQueue valueForKey:@"retainCount"]);
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(stop) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     NSLog(@"3.count---%@",[_eventQueue valueForKey:@"retainCount"]);
}

-(void)stop {
    [self.eventQueue stop];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.eventQueue executeTaskWithBlock:^{
        for (int i=0; i<5; i++) {
            NSString *str = [NSString stringWithFormat:@"%@",@"sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdf"];
        }
    }];
    
    
    [self.eventQueue executeTaskWithTargret:[Person new] action:@selector(beginWork)];
    
}


//-(QXEventQueue *)eventQueue{
//    if (_eventQueue == nil) {
//        NSLog(@"count---%@",[_eventQueue valueForKey:@"retainCount"]);
//        _eventQueue = [[QXEventQueue alloc] init];
//        NSLog(@"2.count---%@",[_eventQueue valueForKey:@"retainCount"]);
//    }
//    return _eventQueue;
//}


-(void)dealloc{
    NSLog(@"%s",__func__);
    NSLog(@"2.count---%@",[_eventQueue valueForKey:@"retainCount"]);
}
@end
