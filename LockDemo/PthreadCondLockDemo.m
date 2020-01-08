//
//  PthreadCondLockDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "PthreadCondLockDemo.h"
#import <pthread.h>

@interface PthreadCondLockDemo ()

@property (nonatomic, assign) NSInteger condition_value;

@end


@implementation PthreadCondLockDemo

- (void)synchronizedTest {
    // 两种初始化方式
    // 1.静态初始化
    static pthread_cond_t cond_lock = PTHREAD_COND_INITIALIZER;
    static pthread_mutex_t mutex_lock = PTHREAD_MUTEX_INITIALIZER; // 需要配合mutex互斥锁使用
    
    // 2.动态创建
    static pthread_cond_t cond_lock1;
    pthread_cond_init(&cond_lock1, NULL);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        pthread_mutex_lock(&mutex_lock);
        while (self.condition_value <= 0) { // 条件成立则暂时解锁并等待
            pthread_cond_wait(&cond_lock, &mutex_lock);
        }
        
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        pthread_mutex_unlock(&mutex_lock);
    }];
    
    [queue addOperationWithBlock:^{
        pthread_mutex_lock(&mutex_lock);
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        self.condition_value = 1; // 一定要更改条件 否则上面read线程条件成立又会wait
        NSLog(@"%@===write===end",[NSThread currentThread]);
        
        pthread_cond_signal(&cond_lock); // 传递信号给等待的线程 而且是在解锁前
//        pthread_cond_broadcast(pthread_cond_t * _Nonnull) // 通知所有线程
        
        pthread_mutex_unlock(&mutex_lock);
    }];
    
    /*
     <NSThread: 0x283783e40>{number = 3, name = (null)}===write===start
     <NSThread: 0x283783e40>{number = 3, name = (null)}===write===end
     <NSThread: 0x28379aa40>{number = 4, name = (null)}===read===start
     <NSThread: 0x28379aa40>{number = 4, name = (null)}===read===end
     */
}

@end
