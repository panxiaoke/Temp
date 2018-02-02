//
//  RJCalculateOperation.m
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJCalculateOperation.h"

@implementation RJCalculateOperation {
    
    NSArray *_numbers;
}

- (instancetype)initWithNumbers:(NSArray *)numbers {
    
    if (self = [super init]) {
        
        _numbers = numbers;
    }
    return self;
}

#pragma mark - Override

- (void)main {
    
    NSInteger maxValue = INT_MIN, minValue = INTMAX_MAX;
    for (NSNumber *num in _numbers) {
        maxValue = num.integerValue > maxValue ? num.integerValue : maxValue;
        minValue = num.integerValue < minValue ? num.integerValue : minValue;
    }
    _minValue = minValue;
    _maxValue = maxValue;
//    NSLog(@"testdata--%ld--执行了",_tag);
}

@end
