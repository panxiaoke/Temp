//
//  ViewController.m
//  Network
//
//  Created by JinZheng on 2018/2/1.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "ViewController.h"

#import "RJDataTaskManager.h"
#import "RJDownloadTaskManager.h"

static NSString *BASE_URL = @"http://127.0.0.1:8080";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - User Interaction

- (IBAction)postBtnClicked:(id)sender {
    
    RJDataTaskManager *manager = [RJDataTaskManager shareInstance];
    [manager fetchDataWithURLStr:BASE_URL path:@"/post" requstType:RJDataRequestTaskTypePost completion:^(NSError *error, NSDictionary *responseData) {
        if (!error) {
            for (NSString *key in responseData.allKeys) {
                NSLog(@"%@:%@",key,responseData[key]);
            }
        }else{
            NSLog(@"%@",error);
        }
    }];
   
}
- (IBAction)getBtnClicked:(id)sender {
    
    RJDataTaskManager *manager = [RJDataTaskManager shareInstance];
    [manager fetchDataWithURLStr:BASE_URL path:@"/get" requstType:RJDataRequestTaskTypeGet completion:^(NSError *error, NSDictionary *responseData) {
        
        if (!error) {
            for (NSString *key in responseData.allKeys) {
                NSLog(@"%@:%@",key,responseData[key]);
            }
        }else {
            NSLog(@"%@",error);
        }
        
        
    }];
}

- (IBAction)frontDownloadBtnClicked:(id)sender {
    
    [[RJDownloadTaskManager shareInstance] downloadFileWithFileURL:@"https://developer.apple.com/library/ios/documentation/Cocoa/Reference/Foundation/ObjC_classic/FoundationObjC.pdf" type:RJDataDownloadTypeFront completion:^(BOOL finished) {
        
    }];
}


@end
