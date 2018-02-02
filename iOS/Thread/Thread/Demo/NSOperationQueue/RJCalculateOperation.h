//
//  RJCalculateOperation.h
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RJCalculateOperation : NSOperation

@property (nonatomic, assign) NSInteger    maxValue;
@property (nonatomic, assign) NSInteger    minValue;
@property (nonatomic, assign) NSInteger    tag;
- (instancetype)initWithNumbers:(NSArray *)numbers;

@end
