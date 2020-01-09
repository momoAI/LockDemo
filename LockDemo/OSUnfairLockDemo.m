//
//  OSUnfairLockDemo.m
//  LockDemo
//
//  Created by MOMO on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "OSUnfairLockDemo.h"
#import <os/lock.h>

@implementation OSUnfairLockDemo

- (void)synchronizedTest {
    __block os_unfair_lock lock = OS_UNFAIR_LOCK_INIT;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        os_unfair_lock_lock(&lock);
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        NSLog(@"%@===write===end",[NSThread currentThread]);
        os_unfair_lock_unlock(&lock);
    }];
    
    [queue addOperationWithBlock:^{
        os_unfair_lock_lock(&lock);
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        os_unfair_lock_unlock(&lock);
    }];
    
    /*
     <NSThread: 0x28141e280>{number = 5, name = (null)}===write===start
     <NSThread: 0x28141e280>{number = 5, name = (null)}===write===end
     <NSThread: 0x28141e740>{number = 6, name = (null)}===read===start
     <NSThread: 0x28141e740>{number = 6, name = (null)}===read===end
     */
}

@end
