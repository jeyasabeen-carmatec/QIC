//
//  APIHelper.h
//  QIC
//
//  Created by anumolu mac mini on 17/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface APIHelper : NSObject
{
    UIView *loadingView;
}

+ (void)postServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params  completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler;

+ (void)login_postServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params : (NSDictionary *_Nullable)headers  completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler;

+ (void)updateServiceCall:(NSString*_Nullable)urlStr andParams:(NSDictionary*_Nullable)params completionHandler:(void (^_Nullable)(id  _Nullable data, NSError * _Nullable error))completionHandler;


+(void)start_animation:(UIViewController *_Nullable)my_controller;
+(void)stop_activity_animation:(UIViewController *_Nullable)my_controller;

+(UIAlertView *_Nullable)createaAlertWithMsg:(NSString *_Nullable)msg andTitle:(NSString *_Nullable)title;

+(NSString *_Nullable)convert_NUll:(NSString *_Nullable)str;



+(NSString *_Nullable)set_count:(NSString *_Nullable)str_count;

@end
