//
//  NSConditionLockDemo.m
//  LockDemo
//
//  Created by MOMO on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "NSConditionLockDemo.h"

@implementation NSConditionLockDemo

- (void)synchronizedTest {
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1]; // 初始化，设置condition=1
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [lock lockWhenCondition:1]; // 当condition=1时 获取锁成功 否则等待（但是首次使用lockWhenCondition时condition不对时也能获取锁成功）
        
        NSLog(@"%@===A===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===A===end",[NSThread currentThread]);
        
        // unlock根据不同的条件 控制对应的线程
        [lock unlockWithCondition:2]; // 解锁，同时设置condition=2并signal；
//        [lock unlockWithCondition:3];
    }];
    
    [queue addOperationWithBlock:^{
        [lock lockWhenCondition:2];
        
        NSLog(@"%@===B===start",[NSThread currentThread]);
        sleep(1);
        NSLog(@"%@===B===end",[NSThread currentThread]);
        
        [lock unlock];
    }];
    
    [queue addOperationWithBlock:^{
        [lock lockWhenCondition:3];
        
        NSLog(@"%@===C===start",[NSThread currentThread]);
        sleep(1);
        NSLog(@"%@===C===end",[NSThread currentThread]);
        
        [lock unlock];
    }];
    
    /*
     NSThread: 0x282b66340>{number = 6, name = (null)}===A===start
     NSThread: 0x282b66340>{number = 6, name = (null)}===A===end
     NSThread: 0x282b68240>{number = 3, name = (null)}===B===start
     NSThread: 0x282b68240>{number = 3, name = (null)}===B===end
     */
}

@end
