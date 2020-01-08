//
//  PthreadRecursionLockDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/8.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "PthreadRecursionLockDemo.h"
#import <pthread.h>

@interface PthreadRecursionLockDemo ()

@property (nonatomic, assign) pthread_mutex_t lock;

@end


@implementation PthreadRecursionLockDemo

- (void)synchronizedTest {
    pthread_mutexattr_t att;
    pthread_mutexattr_init(&att);
    pthread_mutexattr_settype(&att, PTHREAD_MUTEX_RECURSIVE); // PTHREAD_MUTEX_NORMAL普通互斥锁 PTHREAD_MUTEX_RECURSIVE递归锁
    pthread_mutex_init(&_lock, &att);
    pthread_mutexattr_destroy(&att);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [self recursiveTest:3];
    }];
    /*
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===start
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===end
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===start
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===end
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===start
     <NSThread: 0x280d642c0>{number = 3, name = (null)}===end
     */
}

- (void)recursiveTest:(NSInteger)value {
    pthread_mutex_lock(&_lock);
    
    if (value > 0) {
        NSLog(@"%@===start",[NSThread currentThread]);
        sleep(1);
        NSLog(@"%@===end",[NSThread currentThread]);
        [self recursiveTest:value-1];
    }
    
    pthread_mutex_unlock(&_lock);
}

@end
