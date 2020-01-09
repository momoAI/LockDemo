//
//  OSSpinLockDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/8.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "OSSpinLockDemo.h"
#import <libkern/OSAtomic.h>

@implementation OSSpinLockDemo

- (void)synchronizedTest {
    __block OSSpinLock lock = OS_SPINLOCK_INIT;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        OSSpinLockLock(&lock);
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        NSLog(@"%@===write===end",[NSThread currentThread]);
        OSSpinLockUnlock(&lock);
    }];
    
    [queue addOperationWithBlock:^{
        OSSpinLockLock(&lock);
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        OSSpinLockUnlock(&lock);
    }];
    
    /*
     <NSThread: 0x28141e280>{number = 5, name = (null)}===write===start
     <NSThread: 0x28141e280>{number = 5, name = (null)}===write===end
     <NSThread: 0x28141e740>{number = 6, name = (null)}===read===start
     <NSThread: 0x28141e740>{number = 6, name = (null)}===read===end
     */
}

@end
