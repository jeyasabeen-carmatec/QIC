//
//  AppDelegate.h
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@import GoogleMaps;
#import <NewRelicAgent/NewRelic.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIView *notifView;
#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;



@end

