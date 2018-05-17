//
//  APIHelper.m
//  QIC
//
//  Created by anumolu mac mini on 17/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

#pragma post service call

+ (void)postServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler{
       NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:70];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    [request setHTTPBody:postData];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = YES;
    configuration.HTTPMaximumConnectionsPerHost = 10;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
            
            NSLog(@"eror g1:%@",[error localizedDescription]);
        }else{
            NSError *err = nil;
            id resposeJSon = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            if (err) {
                completionHandler(nil,err);
                NSLog(@"eror g2:%@",[error localizedDescription]);
            }else{
                @try {
                    if (resposeJSon) {
                        completionHandler(resposeJSon,nil);
                        
                    }
                    
                } @catch (NSException *exception)
                {
                    NSLog(@" 3 %@",exception);
                }
            }
        }
    }];
    [dataTask resume];
}

#pragma start animation

+(void)start_animation:(UIViewController *_Nullable)my_controller;
{
    @try
    {
    UIView *VW_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    VW_overlay.backgroundColor = [UIColor blackColor];
    VW_overlay.alpha = 0.5;
    VW_overlay.layer.cornerRadius = 5.0f;
    VW_overlay.clipsToBounds = YES;
    VW_overlay.tag = 1234;
    VW_overlay.layer.shadowOffset = CGSizeMake(0, 5);
    
    
    VW_overlay.hidden = NO;
    UIActivityIndicatorView *actiIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   // actiIndicatorView.frame = CGRectMake(0, 0, 50, 60);
    actiIndicatorView.center = my_controller.view.center;
    actiIndicatorView.tag = 1235;
    [actiIndicatorView startAnimating];
    actiIndicatorView.center = VW_overlay.center;
    [VW_overlay addSubview:actiIndicatorView];
    VW_overlay.center = my_controller.view.center;
    [my_controller.view addSubview:VW_overlay];
    }
    @catch(NSException *exception)
    {
        
    }
}

#pragma stop the animation
+(void)stop_activity_animation:(UIViewController *)my_controller
{
    @try
    {
    
    for (UIActivityIndicatorView *activity in my_controller.view.subviews) {
        if (activity.tag == 1235) {
            [activity stopAnimating];
        }
    }
    
    for (UIView *VW_main in my_controller.view.subviews) {
        if (VW_main.tag == 1234) {
            VW_main.hidden = YES;
        }
    }
    }
    @catch(NSException *exception)
    {
        
    }
}


#pragma ALert view creating

+(UIAlertView *)createaAlertWithMsg:(NSString *)msg andTitle:(NSString *)title{
    NSString *ok_btn;
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"story_board_language"] isEqualToString:@"Arabic"])
    {
        ok_btn = @"حسنا";
    }
    else{
        ok_btn = @"Ok";
        
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:msg delegate:nil cancelButtonTitle:ok_btn otherButtonTitles:nil, nil];
    [alert show];
    return  alert;
}

#pragma Convert NUll
+(NSString *_Nullable)convert_NUll:(NSString *_Nullable)str
{
    
    NSString *str_null = str;
    @try
    {
    if([str_null isKindOfClass:[NSNull class]])
    {
        str_null = @"Not mentioned";
    }
    [str stringByReplacingOccurrencesOfString:@"(null)" withString:@"Not mentioned"];
    str_null = [str stringByReplacingOccurrencesOfString:@"<null>" withString:@"Not mentioned"];
    if(str.length < 1)
    {
     str_null = @"Not mentioned";
    }
    }
    @catch(NSException *exception)
    {
        str_null = @"Not mentioned";
    }
    return str_null;
}

#pragma Get API call

+(void)Get_API_call:(NSString *)URL_STR completionHandler:(void (^)(id _Nullable, NSError * _Nullable))completionHandler{
    
    NSString *urlGetuser =[NSString stringWithFormat:@"%@",URL_STR];
    urlGetuser = [urlGetuser stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url = [NSURL URLWithString:urlGetuser];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:70];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = YES;
    configuration.HTTPMaximumConnectionsPerHost = 10;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
            
            NSLog(@"eror c1:%@",[error localizedDescription]);
        }else{
            NSError *err = nil;
            id resposeJSon = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
            if (err) {
                
                completionHandler(nil,err);
                
                NSLog(@"eror c2:%@",[err localizedDescription]);
            }else{
                @try {
                    if (resposeJSon) {
                        completionHandler(resposeJSon,nil);
                        
                    }
                    
                } @catch (NSException *exception) {
                    NSLog(@"%@",exception);
                }
            }
        }
    }];
    [dataTask resume];
}
#pragma Get with Update

+ (void)updateServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"DELETE"];
    [request setTimeoutInterval:70];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    
    [request setHTTPBody:postData];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = YES;
    configuration.HTTPMaximumConnectionsPerHost = 10;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
            
            NSLog(@"eror g1:%@",[error localizedDescription]);
        }else{
            NSError *err = nil;
            id resposeJSon = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            if (err) {
                completionHandler(nil,err);
                NSLog(@"eror g2:%@",[error localizedDescription]);
            }else{
                @try {
                    if (resposeJSon) {
                        completionHandler(resposeJSon,nil);
                        
                    }
                    
                } @catch (NSException *exception)
                {
                    NSLog(@" 3 %@",exception);
                }
            }
        }
    }];
    [dataTask resume];
}
+(NSString *)set_count:(NSString *_Nullable)str_count
{
    if([str_count isEqualToString:@"0"])
    {
        str_count = @"";
    }
   else if(str_count.length > 2)
   {
       str_count = [NSString stringWithFormat:@"%@+",str_count];
   }
   else{
       str_count = str_count;
   }
    
    return str_count;
}

#pragma login_API
+ (void)login_postServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params : (NSDictionary *_Nullable)headers completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:70];
    [request setAllHTTPHeaderFields:headers];
    [request setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    
    [request setHTTPBody:postData];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.allowsCellularAccess = YES;
    configuration.HTTPMaximumConnectionsPerHost = 10;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(id  _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completionHandler(nil,error);
            
            NSLog(@"eror g1:%@",[error localizedDescription]);
        }else{
            NSError *err = nil;
            id resposeJSon = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
            if (err) {
                completionHandler(nil,err);
                NSLog(@"eror g2:%@",[error localizedDescription]);
            }else{
                @try {
                    if (resposeJSon) {
                        completionHandler(resposeJSon,nil);
                        
                    }
                    
                } @catch (NSException *exception)
                {
                    NSLog(@" 3 %@",exception);
                }
            }
        }
    }];
    [dataTask resume];
}


@end
