//
//  RJThread.m
//  Thread
//
//  Created by JinZheng on 2018/1/23.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJThread.h"

@implementation RJThread{
    
    NSArray *_numbers;
}

#pragma mark - Life Circle

- (instancetype)initWithNumbers:(NSArray *)nums{
    
    if ( self  = [super init]) {
        
        _numbers = nums;
    }
    return self;
}

#pragma mark - Private
#pragma mark - Override

- (void)main{
    
    NSInteger maxValue = -1, minValue = INTMAX_MAX;
    for (NSNumber *num in _numbers) {
        
        maxValue = num.integerValue > maxValue ? num.integerValue : maxValue;
        minValue = num.integerValue < minValue ? num.integerValue : minValue;
    }
    self.maxValue = maxValue;
    self.minVlaue = minValue;
}
@end
