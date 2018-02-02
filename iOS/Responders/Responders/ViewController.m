//
//  ViewController.m
//  Responders
//
//  Created by JinZheng on 2018/1/29.
//  Copyright © 2018年 qinrongjun. All rights reserved.
//

#import "ViewController.h"

static NSString *const kBaseURL = @"http://127.0.0.1:8080/test";

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic,strong) NSURLSessionTask *task;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kBaseURL]];
    req.HTTPMethod = @"POST";
    NSDictionary *dict = @{
                           @"message":@"123",
                           @"nick":@"alfa"
                           };
    req.allHTTPHeaderFields = @{
                                @"Content-Type":@"application/json"
                                };
    req.HTTPBody = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:cfg];
    NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
             NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            for (NSString *key in dict.allKeys) {
                NSLog(@"%@:%@",key,dict[key]);
            }
        }else{
            NSLog(@"%@",error);
        }
       
    }];
    [task resume];
    _task = task;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - User Interactin

#pragma mark - Private

#pragma mark - Override

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Touches Began");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Touches Moved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"Touches End");
    [_task resume];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"Touches Cancelled");
}
@end
