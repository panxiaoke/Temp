//
//  RJGreenView.m
//  Responders
//
//  Created by JinZheng on 2018/1/31.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJGreenView.h"

@implementation RJGreenView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"开始");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"移动");
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"取消");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"结束");
}

@end
