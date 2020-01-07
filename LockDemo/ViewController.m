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
    
    id<MMLockProtocol> lock = [[SemaphoreDemo alloc] init];
    [lock synchronizedTest];
    
}

@end
