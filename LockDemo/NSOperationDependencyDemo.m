//
//  NSOperationDependencyDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/9.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "NSOperationDependencyDemo.h"

@implementation NSOperationDependencyDemo

- (void)synchronizedTest {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *taskA = [NSBlockOperation blockOperationWithBlock:^{
        sleep(2);
        NSLog(@"%@===TaskA",[NSThread currentThread]);
    }];
    NSBlockOperation *taskB = [NSBlockOperation blockOperationWithBlock:^{
        sleep(.5);
        NSLog(@"%@===TaskB",[NSThread currentThread]);
    }];
    [taskB addDependency:taskA];
    
    [queue addOperation:taskA];
    [queue addOperation:taskB];
    
    /*
     <NSThread: 0x281af5bc0>{number = 6, name = (null)}===TaskA
     <NSThread: 0x281af5bc0>{number = 6, name = (null)}===TaskB
     */
}

@end
