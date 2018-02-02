//
//  RJGCDTask.m
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJGCDTask.h"

static const NSInteger THREAD_CNT = 4;
static NSString *const MIN_KEY = @"min";
static NSString *const MAX_KEY = @"max";

@implementation RJGCDTask

+ (void)taskForABCDWithGCDGroup {

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.alfa.groupABCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"A");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"B");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"C");
    });
    dispatch_group_notify(group, queue, ^{
        NSLog(@"D");
    });
    
}

+ (void)taskForABCDWithGCDBarrier {
    
    dispatch_queue_t queue = dispatch_queue_create("com.alfa.barrierABCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"A");
    });
    dispatch_async(queue, ^{
        NSLog(@"B");
    });
    dispatch_async(queue, ^{
        NSLog(@"C");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"使用屏障进行隔离");
    });
    dispatch_async(queue, ^{
        NSLog(@"D");
    });
    
    
}

+ (void)taskForCalculateNumbers:(NSArray *)numbers completion:(TaskCompletion)completion {

    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.alfa.taskForCalculateNumbers", DISPATCH_QUEUE_CONCURRENT);
    NSInteger numCnt = numbers.count;
    __block NSInteger max = -1, min = INTMAX_MAX;
    NSLock *lock = [[NSLock alloc] init];
    for (NSInteger i = 0; i < THREAD_CNT; i++) {

        NSInteger offset = i * (numCnt / THREAD_CNT);
        NSInteger count = MIN(numCnt / THREAD_CNT, numCnt - offset);
        NSArray *subset = [numbers subarrayWithRange:NSMakeRange(offset, count)];
        dispatch_group_async(group, concurrentQueue, ^{

            NSInteger maxValue = -1, minValue = INTMAX_MAX;
            for (NSInteger i = 0; i < subset.count; i++) {

                maxValue = [subset[i] integerValue] > maxValue ? [subset[i] integerValue] : maxValue;
                minValue = [subset[i] integerValue] < minValue ? [subset[i] integerValue] : minValue;
            }
            [lock lock];
            max = maxValue > max ? maxValue : max;
            min = minValue < min ? minValue : min;
            [lock unlock];
        });
    }
    dispatch_group_notify(group, concurrentQueue, ^{

        if (completion) {
            completion(max, min);
        }
    });
}

@end
