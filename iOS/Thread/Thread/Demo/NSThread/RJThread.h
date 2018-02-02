//
//  RJThread.h
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJThread : NSThread

@property (nonatomic, assign) NSInteger    maxValue;
@property (nonatomic, assign) NSInteger    minVlaue;

- (instancetype)initWithNumbers:(NSArray *)nums;

@end
