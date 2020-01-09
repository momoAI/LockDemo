//
//  GCDGroupDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "GCDGroupDemo.h"

@implementation GCDGroupDemo

- (void)synchronizedTest {
    // group必须使用自己创建的并发队列 使用global全局队列无效 
    dispatch_queue_t queue = dispatch_queue_create("concurrent_queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0); xxx
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        sleep(1);
        NSLog(@"%@===TaskA",[NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        sleep(1);
        NSLog(@"%@===TaskB",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"%@===TaskC",[NSThread currentThread]);
    });
//    dispatch_async(queue, ^{
//        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC))); // 可以设置等待的超时时间
//        NSLog(@"%@===TaskC",[NSThread currentThread]);
//    });
    
    /*
     <NSThread: 0x2824bc000>{number = 5, name = (null)}===TaskA
     <NSThread: 0x2824bc000>{number = 5, name = (null)}===TaskB
     <NSThread: 0x2824bc000>{number = 5, name = (null)}===TaskC
     */
}

@end
