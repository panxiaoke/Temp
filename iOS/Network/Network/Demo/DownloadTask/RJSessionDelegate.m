//
//  RJSessionDelegate.m
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJSessionDelegate.h"

@implementation RJSessionDelegate

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    static RJSessionDelegate *delegate;
    dispatch_once(&onceToken, ^{
        
        delegate = [[self alloc] init];
    });
    return delegate;
}

//一个下载任务完时调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"下载完成了");
}

//下载速度
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"testdata---%0.2f",bytesWritten*1.0/totalBytesWritten);
}

//恢复下载成功
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    NSLog(@"testdata--%@",@"恢复下载");
}

//下载失败
- (void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    NSLog(@"%@",error);
    
}

@end
