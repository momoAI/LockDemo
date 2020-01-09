//
//  PthreadMutexLockDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "PthreadMutexLockDemo.h"
#import <pthread.h>

@implementation PthreadMutexLockDemo

- (void)synchronizedTest {
    // 两种初始化方式
    // 1.静态初始化
    static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
    
    // 2.动态创建
    pthread_mutex_t lock1;
    pthread_mutex_init(&lock1, NULL); // 可以根据需要配置pthread_mutexattr NULL默认为互斥锁

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        pthread_mutex_lock(&lock);
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        NSLog(@"%@===write===end",[NSThread currentThread]);
        pthread_mutex_unlock(&lock);
    }];

    [queue addOperationWithBlock:^{
        pthread_mutex_lock(&lock);
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        pthread_mutex_unlock(&lock);
    }];
    
    // trylock
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperationWithBlock:^{
//        pthread_mutex_trylock(&lock); // 尝试加锁，如果当前mutex已经被锁或者不可用，就直接return了，不会把线程卡住
//        NSLog(@"%@===write===start",[NSThread currentThread]);
//        sleep(3);
//        NSLog(@"%@===write===end",[NSThread currentThread]);
//        pthread_mutex_unlock(&lock);
//    }];
//
//    [queue addOperationWithBlock:^{
//        pthread_mutex_lock(&lock);
//        NSLog(@"%@===read===start",[NSThread currentThread]);
//        sleep(2);
//        NSLog(@"%@===read===end",[NSThread currentThread]);
//        pthread_mutex_unlock(&lock);
//    }];
    
    /*
     <NSThread: 0x2834863c0>{number = 5, name = (null)}===write===start
     <NSThread: 0x2834863c0>{number = 5, name = (null)}===write===end
     <NSThread: 0x2834848c0>{number = 6, name = (null)}===read===start
     <NSThread: 0x2834848c0>{number = 6, name = (null)}===read===end
     
     <NSThread: 0x283486200>{number = 8, name = (null)}===read===start
     <NSThread: 0x283486200>{number = 8, name = (null)}===read===end
     <NSThread: 0x283486480>{number = 7, name = (null)}===write===start
     <NSThread: 0x283486480>{number = 7, name = (null)}===write===end
     */
}

@end
