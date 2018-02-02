//
//  RJDownloadTaskManager.h
//  Network
//
//  Created by JinZheng on 2018/2/2.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadTaskCompletion)(BOOL finished);

typedef NS_ENUM(NSInteger,RJDataDownloadType) {
    RJDataDownloadTypeFront,    //前台下载
    RJDataDownloadTypeBackground //后台下载
};

@interface RJDownloadTaskManager : NSObject

+ (instancetype)shareInstance;

- (void)downloadFileWithFileURL:(NSString *)fileURL type:(RJDataDownloadType)type completion:(DownloadTaskCompletion)completion;

@end
