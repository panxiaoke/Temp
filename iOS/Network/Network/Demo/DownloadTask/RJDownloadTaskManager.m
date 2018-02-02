//
//  RJDownloadTaskManager.m
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJDownloadTaskManager.h"
#import "RJSessionDelegate.h"

@implementation RJDownloadTaskManager

#pragma mark - Life Circle
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static RJDownloadTaskManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

#pragma mark - Public Interface
- (void)downloadFileWithFileURL:(NSString *)fileURL type:(RJDataDownloadType)type completion:(DownloadTaskCompletion)completion {
    
    switch (type) {
        case RJDataDownloadTypeFront:
            [self standardDownloadFileWithFileURL:fileURL];
            break;
            
        default:
            break;
    }
}

#pragma mark - Private Interface
- (void)standardDownloadFileWithFileURL:(NSString *)fileURL {
    
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *operationQueue = [NSOperationQueue mainQueue];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg delegate: [RJSessionDelegate shareInstance] delegateQueue:operationQueue];
    NSURLSessionTask *task = [session downloadTaskWithURL:[NSURL URLWithString:fileURL]];
    [task resume];
    
}

- (void)backgroudDownloadFileWithFileURL:(NSString *)fileURL {
    
    
}



@end
