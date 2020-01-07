//
//  PthreadRWLockDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "PthreadRWLockDemo.h"
#import "MMLockHeader.h"

@implementation PthreadRWLockDemo

- (void)synchronizedTest {
    // 两种初始化方式
    // 1.静态初始化
    static pthread_rwlock_t lock = PTHREAD_RWLOCK_INITIALIZER;
    
    // 2.动态创建
    pthread_rwlock_t lock1;
    pthread_rwlock_init(&lock1, NULL);
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < 3; i ++) {
        [queue addOperationWithBlock:^{
            pthread_rwlock_wrlock(&lock);
            NSLog(@"%@===write===start",[NSThread currentThread]);
            sleep(3);
            NSLog(@"%@===write===end",[NSThread currentThread]);
            pthread_rwlock_unlock(&lock);
        }];
    }
    
    for (int i = 0; i < 3; i ++) {
        [queue addOperationWithBlock:^{
            pthread_rwlock_rdlock(&lock);
            NSLog(@"%@===read===start",[NSThread currentThread]);
            sleep(2);
            NSLog(@"%@===read===end",[NSThread currentThread]);
            pthread_rwlock_unlock(&lock);
        }];
    }
    
    /*
     <NSThread: 0x281b83440>{number = 5, name = (null)}===write===start
     <NSThread: 0x281b83440>{number = 5, name = (null)}===write===end
     <NSThread: 0x281b83400>{number = 6, name = (null)}===write===start
     <NSThread: 0x281b83400>{number = 6, name = (null)}===write===end
     <NSThread: 0x281b94940>{number = 4, name = (null)}===write===start
     <NSThread: 0x281b94940>{number = 4, name = (null)}===write===end
     <NSThread: 0x281b9aa00>{number = 3, name = (null)}===read===start
     <NSThread: 0x281b864c0>{number = 7, name = (null)}===read===start
     <NSThread: 0x281b87780>{number = 8, name = (null)}===read===start
     <NSThread: 0x281b87780>{number = 8, name = (null)}===read===end
     <NSThread: 0x281b9aa00>{number = 3, name = (null)}===read===end
     <NSThread: 0x281b864c0>{number = 7, name = (null)}===read===end
     */
}

@end
