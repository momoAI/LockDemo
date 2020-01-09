//
//  NSConditionDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "NSConditionDemo.h"

@interface NSConditionDemo ()

@property (nonatomic, assign) NSInteger condition_value;

@end


@implementation NSConditionDemo

- (void)synchronizedTest {
    NSCondition *lock = [[NSCondition alloc] init];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [lock lock];
        
        while (self.condition_value <= 0) { // 条件成立则暂时解锁并等待
            [lock wait];
        }
        
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        
        [lock unlock];
    }];
    
    [queue addOperationWithBlock:^{
        [lock lock];
        
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        self.condition_value = 1; // 一定要更改条件 否则上面read线程条件成立又会wait
        NSLog(@"%@===write===end",[NSThread currentThread]);
        
        [lock signal]; // 传递信号给等待的线程 而且是在解锁前
//        [lock broadcast] // 通知所有线程
        
        [lock unlock];
    }];
    
    /*
     <NSThread: 0x283783e40>{number = 3, name = (null)}===write===start
     <NSThread: 0x283783e40>{number = 3, name = (null)}===write===end
     <NSThread: 0x28379aa40>{number = 4, name = (null)}===read===start
     <NSThread: 0x28379aa40>{number = 4, name = (null)}===read===end
     */
}

@end
