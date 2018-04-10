//
//  VC_dependents.h
//  QIC
//
//  Created by anumolu mac mini on 05/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_dependents : UIViewController
#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;
#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;

#pragma Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_back;

#pragma Favourites Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_favourite;

@end
