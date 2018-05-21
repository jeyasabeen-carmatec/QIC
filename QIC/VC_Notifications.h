//
//  VC_Notifications.h
//  QIC
//
//  Created by anumolu mac mini on 17/05/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_Notifications : UIViewController
@property(nonatomic,weak) IBOutlet UITableView *TBL_notifications;
@property(nonatomic,weak) IBOutlet UIButton *BTN_back;
@property(nonatomic,weak) IBOutlet UITextView *TXT_view;
#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;

#pragma Search bar views

@property(nonatomic,weak) IBOutlet UILabel *LBL_search_place_holder;
@property(nonatomic,weak) IBOutlet UITextField *TXT_search;
@property(nonatomic,weak) IBOutlet UIButton *BTN_search;

@end
