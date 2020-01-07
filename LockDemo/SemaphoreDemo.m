//
//  SemaphoreDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "SemaphoreDemo.h"
#import "MMLockHeader.h"

@implementation SemaphoreDemo

- (void)synchronizedTest {
    sem_t *sem = sem_open("sem", 0); // 创建
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        sem_wait(sem);
        NSLog(@"%@===write===start",[NSThread currentThread]);
        sleep(3);
        NSLog(@"%@===write===end",[NSThread currentThread]);
        
    }];
    
    [queue addOperationWithBlock:^{
        NSLog(@"%@===read===start",[NSThread currentThread]);
        sleep(2);
        NSLog(@"%@===read===end",[NSThread currentThread]);
        sem_post(sem);
    }];
    
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
