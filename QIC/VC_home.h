//
//  VC_home.h
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_home : UIViewController<home_page_protocols>

#pragma Tab bar 
@property(nonatomic,weak) IBOutlet UITabBar *TAB_menu;



#pragma Main view

@property(nonatomic,weak) IBOutlet UIView *VW_main;

@end
