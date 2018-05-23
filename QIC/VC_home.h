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
@property(nonatomic,strong) IBOutlet UITabBar *TAB_menu;

@property(nonatomic,strong) IBOutlet UIButton *BTN_favourite;


#pragma Main view

@property(nonatomic,strong) IBOutlet UIView *VW_main;

@end
