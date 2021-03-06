//
//  VC_profile.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_profile : UIViewController

#pragma Main view Components

@property(nonatomic,weak) IBOutlet UIView *VW_main;
@property(nonatomic,weak) IBOutlet UIView *VW_IMG_background;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_prfoile_image;
@property(nonatomic,weak) IBOutlet UITextField *LBL_profile_name;
@property(nonatomic,weak) IBOutlet UITextField *LBL_mobile_number;
@property(nonatomic,weak) IBOutlet UIButton *BTN_camera;


@property(nonatomic,weak) IBOutlet UITableView *TBL_profile;

#pragma VIew controller view Components

@property(nonatomic,weak) IBOutlet UIScrollView *Scroll_contents;

#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;


@end
