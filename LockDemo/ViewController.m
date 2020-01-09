//
//  ViewController.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "ViewController.h"
#import "MMLockHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    id<MMLockProtocol> lock = [[PthreadMutexLockDemo alloc] init];
//    [lock synchronizedTest];
    
//    id<MMLockProtocol> lock = [[PthreadRWLockDemo alloc] init];
//    [lock synchronizedTest];
    
//    id<MMLockProtocol> lock = [[PthreadJoinDemo alloc] init];
//    [lock synchronizedTest];
    
//    id<MMLockProtocol> lock = [[PthreadCondLockDemo alloc] init];
//    [lock synchronizedTest];
//
//    id<MMLockProtocol> lock = [[SemaphoreDemo alloc] init];
//    [lock synchronizedTest];
//
//    id<MMLockProtocol> lock = [[PthreadRecursionLockDemo alloc] init];
//    [lock synchronizedTest];
//
//    id<MMLockProtocol> lock = [[OSSpinLockDemo alloc] init];
//    [lock synchronizedTest];
    
//    id<MMLockProtocol> lock = [[OSUnfairLockDemo alloc] init];
//    [lock synchronizedTest];
    
//    NSLock
//    - (void)lock;
//    - (void)unlock;
//    - (BOOL)tryLock;
//    - (BOOL)lockBeforeDate:(NSDate *)limit;
    
//    NSRecursiveLock
    //    - (void)lock;
    //    - (void)unlock;
    //    - (BOOL)tryLock;
    //    - (BOOL)lockBeforeDate:(NSDate *)limit;
//
//    id<MMLockProtocol> lock = [[NSConditionDemo alloc] init];
//    [lock synchronizedTest];
//
//    id<MMLockProtocol> lock = [[NSConditionLockDemo alloc] init];
//    [lock synchronizedTest];
    
//    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    dispatch_semaphore_signal(sem);
    
//    dispatch_queue_t queue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue, ^{
//        // ThreadA dosomething....
//    });
//    dispatch_async(queue, ^{
//        // ThreadB dosomething....
//    });
//
//    id<MMLockProtocol> lock = [[GCDGroupDemo alloc] init];
//    [lock synchronizedTest];
//
//    id<MMLockProtocol> lock = [[GCDBarrierDemo alloc] init];
//    [lock synchronizedTest];
    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 1;
//
//    // similarly to the `dispatch_barrier_async` function.
//    [queue addBarrierBlock:^{
//
//    }];

    id<MMLockProtocol> lock = [[NSOperationDependencyDemo alloc] init];
    [lock synchronizedTest];
    
}

@end
