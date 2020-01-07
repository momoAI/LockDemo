//
//  PthreadJoinDemo.m
//  LockDemo
//
//  Created by 研发部-陆续 on 2020/1/7.
//  Copyright © 2020 MOMO. All rights reserved.
//

#import "PthreadJoinDemo.h"
#import "MMLockHeader.h"

@interface PthreadJoinDemo ()

@property (nonatomic, assign) pthread_t thread1;
@property (nonatomic, assign) pthread_t thread2;

@end


@implementation PthreadJoinDemo

static pthread_t thread1;
static pthread_t thread2;

void * writeFunc(void *args) {
    NSLog(@"%u===write===start",(unsigned int)pthread_self());
    sleep(3);
    NSLog(@"%u===write===end",(unsigned int)pthread_self());
    pthread_exit(NULL);
    return NULL;
}

void* readFunc(void *args) {
    pthread_join(thread1, NULL);
    NSLog(@"%u===read===start",(unsigned int)pthread_self());
    sleep(2);
    NSLog(@"%u===read===end",(unsigned int)pthread_self());
    return NULL;
}

- (void)synchronizedTest {
    pthread_create(&thread1, NULL, writeFunc, NULL);
    pthread_create(&thread2, NULL, readFunc, NULL);
    
    /*
     871015936===write===start
     871015936===write===end
     871589376===read===start
     871589376===read===end
     */
}

@end
