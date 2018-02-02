//
//  RJDataTaskManager.m
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "RJDataTaskManager.h"

@implementation RJDataTaskManager

#pragma mark - Life Circle

+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    static RJDataTaskManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[RJDataTaskManager alloc] init];
    });
    return manager;
}

#pragma mark - Public Interface

- (void)fetchDataWithURLStr:(NSString *)urlStr path:(NSString *)path requstType:(RJDataRequestTaskType)type completion:(DataTaskCompletion)completion{
    
    switch (type) {
        case RJDataRequestTaskTypeGet:
            [self fetchDataUseGetWithURLStr:urlStr path:path completion:completion];
            break;
        case RJDataRequestTaskTypePost:
            [self fetchDataUsePostWithURLStr:urlStr path:path completion:completion];
            break;
        default:
            break;
    }
}

#pragma mark - Private Interface


- (void)fetchDataUseGetWithURLStr:(NSString *)urlStr path:(NSString *)path completion:(DataTaskCompletion)completion{
    
    NSString *requestStr = [NSString stringWithFormat:@"%@%@?firstname=qin&lastname=rongjun",urlStr,path];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestStr]];
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            if (completion) {
                completion(nil,dict);
            }
            
        }else{
            if (completion) {
                completion(error,nil);
            }
        }
    }];
    [task resume];
}

- (void)fetchDataUsePostWithURLStr:(NSString *)urlStr path:(NSString *)path completion:(DataTaskCompletion)completion{
    
    NSDictionary *dict = @{
                           @"message":@"Network Programing",
                           @"nick":@"alfa"
                           };
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",urlStr,path];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestStr]];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSError *error = nil;
    //    字典转data
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (!error) {
        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg];
        NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                if (completion) {
                    completion(nil,dict);
                }
            }else {
                if (completion) {
                    completion(nil,dict);
                }
            }
        }];
        [task resume];
    }else {
        NSLog(@"%@",error);
    }
    
}


@end
