//
//  AppDelegate.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NewRelicAgent startWithApplicationToken:@"AA31f46cdbec234c294afd0758c8d1a8debd72c23e"];
    [GMSServices provideAPIKey:@"AIzaSyDdjUq1m4XayB118EUlOyd68IaBsnDGj2Q"];
    
   
    
    if(@available(iOS 10, *)){
        UNUserNotificationCenter *notifiCenter = [UNUserNotificationCenter currentNotificationCenter];
        notifiCenter.delegate = self;
        [notifiCenter requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                [[UIApplication sharedApplication] registerForRemoteNotifications];
            }
        }];
    }
    else
    {
        UIUserNotificationSettings* notificationSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    }
    
  
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//    NSNotification *notif = [NSNotification notificationWithName:@"NEW_NOTIFICATION" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotification:notif];
    
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - APNS
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString   *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"])
    {
        
    }
    else if ([identifier isEqualToString:@"answerAction"])
    {
        
    }
    
    NSLog(@"User info appdeliigate = %@",userInfo);
}
#else
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
    
    
    
}
#endif


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"Did Register for Remote Notifications with Device Token (%@)", deviceToken);
    
    
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSUInteger lenthtotes = [token length];
    NSUInteger req = 64;
    if (lenthtotes == req) {
        NSLog(@"uploaded token: %@", token);
        
        [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"DEV_TOK"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSNotification *notif = [NSNotification notificationWithName:@"NEW_TOKEN_AVAILABLE" object:token];
        [[NSNotificationCenter defaultCenter] postNotification:notif];
    }
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info : %@",notification.request.content.userInfo);
    
   // [self.delegate read_status_updates];
    NSNotification *notificaion = [NSNotification notificationWithName:@"NEW_NOTIFICATIO_COUNT" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notificaion];
    
    
    
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
    
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"notification_DICT"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"Notification Received .. Dictionary %@",[[NSUserDefaults standardUserDefaults] dictionaryForKey:@"notification_DICT"]);
    
     
    
    if ( application.applicationState == UIApplicationStateActive ){
        // app was already in the foreground
      
        
        
        @try {
            NSDictionary *DICTN_notification = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"notification_DICT"];
            NSDictionary *aps = [DICTN_notification valueForKey:@"aps"];
            NSDictionary *alert = [aps valueForKey:@"alert"];
            NSString *notifMessage = [alert valueForKey:@"body"];
            
            //Define notifView as UIView in the header file
//            [_notifView removeFromSuperview]; //If already existing
//
//            _notifView = [[UIView alloc] initWithFrame:CGRectMake(0, -70, self.window.frame.size.width, 80)];
//            [_notifView setBackgroundColor:[UIColor clearColor]];
//
//            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,15,30,30)];
//            imageView.image = [UIImage imageNamed:@"AppLogo.png"];
//
//            UILabel *myLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 15, self.window.frame.size.width - 100 , 30)];
//            myLabel.font = [UIFont fontWithName:@"Helvetica" size:17.0];
//            myLabel.text = notifMessage;
//
//            [myLabel setTextColor:[UIColor whiteColor]];
//            [myLabel setNumberOfLines:0];
//
//            [_notifView setAlpha:0.95];
//
//            //The Icon
//            [_notifView addSubview:imageView];
//
//            //The Text
//            [_notifView addSubview:myLabel];
//
//            //The View
//            [self.window addSubview:_notifView];
//
////            UITapGestureRecognizer *tapToDismissNotif = [[UITapGestureRecognizer alloc] initWithTarget:self
////                                                                                                action:@selector(notify_me)];
////            tapToDismissNotif.numberOfTapsRequired = 1;
////            tapToDismissNotif.numberOfTouchesRequired = 1;
////
////            [_notifView addGestureRecognizer:tapToDismissNotif];
//
//
//            [UIView animateWithDuration:1.0 delay:.1 usingSpringWithDamping:0.5 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
//
//                [_notifView setFrame:CGRectMake(0, 0, self.window.frame.size.width, 60)];
//
//            } completion:^(BOOL finished) {
//
//
//            }];
        } @catch (NSException *exception) {
            NSLog(@"The notification exception %@",exception);
        }
    }
    else
    {
        completionHandler(UIBackgroundFetchResultNewData);

//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intial_vc *vc = [sb instantiateViewControllerWithIdentifier:@"initial_VC_cc"];
//        self.window.rootViewController = vc;
    }
    
    NSNotification *notif = [NSNotification notificationWithName:@"NEW_NOTIFICATION" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notif];
    
    
    
    NSNotification *notify = [NSNotification notificationWithName:@"NEW_NOTIFICATION FOREGROUND" object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
    
   
     [self.delegate notify_me];
    
      //  [self applicationDidFinishLaunching:[UIApplication sharedApplication]];
}

-(void) notify_me
{
    
    _notifView.hidden = YES;
    [self.delegate notify_me];
//    NSDictionary *DICTN_notification = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"notification_DICT"];
//    if (DICTN_notification) {
//        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        Intial_vc *vc = [sb instantiateViewControllerWithIdentifier:@"initial_VC_cc"];
//        self.window.rootViewController = vc;
//    }
}
@end
