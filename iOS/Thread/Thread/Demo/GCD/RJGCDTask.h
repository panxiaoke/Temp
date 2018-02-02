//
//  RJGCDTask.h
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TaskCompletion)(NSInteger max, NSInteger min);

@interface RJGCDTask : NSObject

/**
 并发执行A、B、C，最后执行D
 */
+ (void)taskForABCDWithGCDGroup;

+ (void)taskForABCDWithGCDBarrier;

+ (void)taskForCalculateNumbers:(NSArray *)numbers completion:(TaskCompletion)completion;

@end
