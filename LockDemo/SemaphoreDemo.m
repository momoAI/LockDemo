//
//  SemaphoreDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "SemaphoreDemo.h"
#import <semaphore.h>

@implementation SemaphoreDemo

//- (void)synchronizedTest {
//    // 创建 原型sem_t *sem_open(const char *name,int oflag,mode_t mode,unsigned int value);
//    // name 信号的外部名字
//    // oflag 选择创建或打开一个现有的信号灯
//    // mode 权限位
//    // value 信号初始值
//    sem_t * sem = sem_open("semname", O_CREAT, 0644, 1);
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperationWithBlock:^{
//        sem_wait(sem);
//        NSLog(@"%@===write===start",[NSThread currentThread]);
//        sleep(3);
//        NSLog(@"%@===write===end",[NSThread currentThread]);
//        sem_post(sem);
//    }];
//
//    [queue addOperationWithBlock:^{
//        sem_wait(sem);
//        NSLog(@"%@===read===start",[NSThread currentThread]);
//        sleep(2);
//        NSLog(@"%@===read===end",[NSThread currentThread]);
//        sem_post(sem);
//    }];
//
//    /*
//     <NSThread: 0x2837f6240>{number = 5, name = (null)}===write===start
//     <NSThread: 0x2837f6240>{number = 5, name = (null)}===write===end
//     <NSThread: 0x2837fc8c0>{number = 6, name = (null)}===read===start
//     <NSThread: 0x2837fc8c0>{number = 6, name = (null)}===read===end
//     */
//}

// 控制并发数
- (void)synchronizedTest {
    sem_t *sem = sem_open("semname_count", O_CREAT, 0644, 3);

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    for (int i = 0; i < 21; i ++) {
        [queue addOperationWithBlock:^{
            sem_wait(sem);
            NSLog(@"%@===write===start",[NSThread currentThread]);
            sleep(2);
            NSLog(@"%@===write===end",[NSThread currentThread]);
            sem_post(sem);
        }];
    }

    // 效果类似以下代码
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 3;
//    for (int i = 0; i < 21; i ++) {
//        [queue addOperationWithBlock:^{
//            NSLog(@"%@===write===start",[NSThread currentThread]);
//            sleep(2);
//            NSLog(@"%@===write===end",[NSThread currentThread]);
//        }];
//    }
    
    /*
     <NSThread: 0x280431380>{number = 6, name = (null)}===write===start
     <NSThread: 0x28040cb80>{number = 5, name = (null)}===write===start
     <NSThread: 0x280431500>{number = 7, name = (null)}===write===start
     <NSThread: 0x28040cb80>{number = 5, name = (null)}===write===end
     <NSThread: 0x28040cb80>{number = 5, name = (null)}===write===start
     <NSThread: 0x280431380>{number = 6, name = (null)}===write===end
     <NSThread: 0x280431380>{number = 6, name = (null)}===write===start
     ....
     */
}


@end
