//
//  RJDataTaskManager.h
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DataTaskCompletion)(NSError *error, NSDictionary *responseData);
typedef NS_ENUM(NSInteger,RJDataRequestTaskType){
    RJDataRequestTaskTypeGet,
    RJDataRequestTaskTypePost
};
@interface RJDataTaskManager : NSObject

+ (instancetype)shareInstance;

- (void)fetchDataWithURLStr:(NSString *)urlStr path:(NSString *)path requstType:(RJDataRequestTaskType)type completion:(DataTaskCompletion)completion;

@end
