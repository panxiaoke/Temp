//
//  ViewController.m
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "ViewController.h"
#import "RJThread.h"
#import "RJGCDTask.h"
#import "RJCalculateOperation.h"
static const NSInteger MAX_N = 10000000;
static const NSInteger THREAD_CNT = 4;
@interface ViewController ()

@end

@implementation ViewController {
    NSArray *_numbers;
    NSOperationQueue *_queue;
    NSInteger _realMaxVal;
    NSInteger _realMinVal;
}

#pragma mark - LifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self p_initNumbers];
    //    [self p_findMaxMinValueWithNSThread];
        [self p_findMaxMinValWithGCD];
//        [self p_finMaxMinValueWithOperationQueue];
    //    [RJGCDTask taskForABCDWithGCDGroup];
//    [RJGCDTask taskForABCDWithGCDBarrier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_queue removeObserver:self forKeyPath:@"operationCount"];
}

#pragma mark - Private
- (void)p_findMaxMinValueWithNSThread {
    NSMutableSet *threadSet = [NSMutableSet setWithCapacity:THREAD_CNT];
    for (NSInteger i = 0; i < THREAD_CNT; i++) {
        //      计算偏移量
        NSInteger offset = i * (MAX_N / THREAD_CNT);
        NSInteger count = MIN(MAX_N / THREAD_CNT, MAX_N - offset);
        NSRange range = NSMakeRange(offset, count);
        NSArray *numbers = [self->_numbers subarrayWithRange:range];
        RJThread *thread = [[RJThread alloc] initWithNumbers:numbers];
        [threadSet addObject:thread];
        [thread start];
    }

    __block NSInteger completedThreadCnt = 0;
    __block NSInteger maxValue = -1, minValue = INTMAX_MAX;

    //    这里必须优化
    while (0 < threadSet.count) {
        [threadSet enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL *_Nonnull stop) {

            RJThread *thread = (RJThread *) obj;
            if (thread.finished) {
                completedThreadCnt++;
                [threadSet removeObject:obj];
                maxValue = thread.maxValue > maxValue ? thread.maxValue : maxValue;
                minValue = thread.minVlaue < minValue ? thread.minVlaue : minValue;
            }
            if (THREAD_CNT == completedThreadCnt) {
                *stop = true;
            }
        }];
    }

    NSLog(@"%s: max=%ld  min=%ld", __func__, maxValue, minValue);
}

- (void)p_findMaxMinValWithGCD {
    [RJGCDTask taskForCalculateNumbers:_numbers
                            completion:^(NSInteger max, NSInteger min) {

                                NSLog(@"%s:max=%ld min=%ld", __func__, max, min);
                            }];
}

- (void)p_finMaxMinValueWithOperationQueue {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSMutableArray *operations = [NSMutableArray array];
    __block NSInteger maxValue = INT_MIN, minValue = INTMAX_MAX;
    for (NSInteger i = 0; i < THREAD_CNT; i++) {
        NSInteger offset = i * (MAX_N / THREAD_CNT);
        NSInteger count = MIN(MAX_N / THREAD_CNT, MAX_N - offset);
        NSRange range = NSMakeRange(offset, count);
        NSArray *subset = [_numbers subarrayWithRange:range];
        RJCalculateOperation *operation =
            [[RJCalculateOperation alloc] initWithNumbers:subset];
        __weak NSOperationQueue *weakQueue = queue;
        operation.completionBlock = ^{
            maxValue = operation.maxValue > maxValue ? operation.maxValue : maxValue;
            minValue = operation.minValue < minValue ? operation.minValue : minValue;
            if (0 == weakQueue.operationCount) {
                NSLog(@"max=%ld----min=%ld", maxValue, minValue);
            }
        };
        operation.tag = i;
        [operations addObject:operation];
        //        [queue addOperation:operation];
    }
    [queue addOperations:operations waitUntilFinished:NO];
    NSLog(@"----------我是分割线---------");
}

- (void)p_initNumbers {
   
    _realMaxVal = INT_MIN;
    _realMinVal = INTMAX_MAX;
    
    NSMutableArray *mutableNumbersArr = [NSMutableArray array];
    for (NSInteger i = 0; i < MAX_N; i++) {
        NSInteger num = arc4random() % MAX_N + 1;
        [mutableNumbersArr addObject:@(num)];
        _realMaxVal = num > _realMaxVal ? num : _realMaxVal;
        _realMinVal = num < _realMinVal ? num : _realMinVal;
    }
    _numbers = [mutableNumbersArr copy];
    NSLog(@"testdata----realMaxVal=%ld---realMinVal=%ld",_realMaxVal,_realMinVal);
}

#pragma mark - Override

@end
