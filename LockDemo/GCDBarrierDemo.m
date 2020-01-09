//
//  GCDBarrierDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "GCDBarrierDemo.h"

@implementation GCDBarrierDemo

- (void)synchronizedTest {
    dispatch_queue_t queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"%@===TaskA",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"%@===TaskB",[NSThread currentThread]);
    });
    
    // async不会阻塞当前线程（主线程）
    dispatch_barrier_async(queue, ^{
        NSLog(@"%@===Barrier",[NSThread currentThread]);
    });
    // sync会阻塞当前线程（主线程）
//    dispatch_barrier_sync(queue, ^{
//        NSLog(@"%@===Barrier",[NSThread currentThread]);
//    });
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"%@===TaskC",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"%@===TaskD",[NSThread currentThread]);
    });

    NSLog(@"%@===MainTask",[NSThread currentThread]);
    
    /*
     <NSThread: 0x2816bbc40>{number = 1, name = main}===MainTask
     <NSThread: 0x2816fe440>{number = 3, name = (null)}===TaskB
     <NSThread: 0x2816877c0>{number = 4, name = (null)}===TaskA
     <NSThread: 0x2816877c0>{number = 4, name = (null)}===Barrier
     <NSThread: 0x2816fe440>{number = 3, name = (null)}===TaskD
     <NSThread: 0x2816877c0>{number = 4, name = (null)}===TaskC
     */
}

// barrier实现读写锁
- (void)rwTest {
    dispatch_queue_t queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i < 3; i ++) {
        dispatch_async(queue, ^{
            sleep(1);
            NSLog(@"%@===read",[NSThread currentThread]);
        });
    }
    
    for (int i = 0; i < 3; i ++) {
        dispatch_barrier_async(queue, ^{
            sleep(1);
            NSLog(@"%@===write",[NSThread currentThread]);
        });
    }
    
    for (int i = 0; i < 3; i ++) {
        dispatch_async(queue, ^{
            sleep(1);
            NSLog(@"%@===read",[NSThread currentThread]);
        });
    }
    
    /*
     <NSThread: 0x282a04880>{number = 4, name = (null)}===read
     <NSThread: 0x282a13100>{number = 6, name = (null)}===read
     <NSThread: 0x282a050c0>{number = 5, name = (null)}===read
     <NSThread: 0x282a4ee40>{number = 1, name = main}===write
     <NSThread: 0x282a4ee40>{number = 1, name = main}===write
     <NSThread: 0x282a4ee40>{number = 1, name = main}===write
     <NSThread: 0x282a050c0>{number = 5, name = (null)}===read
     <NSThread: 0x282a13400>{number = 7, name = (null)}===read
     <NSThread: 0x282a04880>{number = 4, name = (null)}===read
     */
}

@end
