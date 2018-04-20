//
//  VC_health_card.h
//  QIC
//
//  Created by anumolu mac mini on 19/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"


@interface VC_health_card : UIViewController
@property(nonatomic,weak) IBOutlet UIImageView  *IMG_card;

@property(nonatomic,weak) IBOutlet UIImageView  *IMG_profile;
@property(nonatomic,weak) IBOutlet UILabel  *LBL_name;
@property(nonatomic,weak) IBOutlet UILabel  *LBL_card_number;
@property(nonatomic,weak) IBOutlet UILabel  *LBL_expiry_date;
@property(nonatomic,weak) IBOutlet UIButton  *BTN_back;

#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;


@end
