//
//  VC_profile.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_profile : UIViewController

#pragma Main view Components

@property(nonatomic,weak) IBOutlet UIView *VW_main;
@property(nonatomic,weak) IBOutlet UIView *VW_IMG_background;
@property(nonatomic,weak) IBOutlet UIView *IMG_prfoile_image;
@property(nonatomic,weak) IBOutlet UILabel *LBL_profile_name;
@property(nonatomic,weak) IBOutlet UITableView *TBL_profile;

#pragma VIew controller view Components

@property(nonatomic,weak) IBOutlet UIScrollView *Scroll_contents;


@end
