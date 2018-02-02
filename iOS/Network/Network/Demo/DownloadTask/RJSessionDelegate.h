//
//  RJSessionDelegate.h
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CompletionHandler)(void);

@interface RJSessionDelegate : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSURLSessionStreamDelegate>

+ (instancetype)shareInstance;

@property NSMutableDictionary <NSString *, CompletionHandler> *completionHandlers;

@end
