//
//  VC_sub_categories.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_sub_categories : UIViewController

#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;

#pragma Button

@property(nonatomic,weak) IBOutlet UIButton *BTN_bcak;

@property(nonatomic,assign) id <home_page_protocols> delegate;


#pragma Favourites Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_favourite;


#pragma Search bar views

@property(nonatomic,weak) IBOutlet UILabel *LBL_search_place_holder;
@property(nonatomic,weak) IBOutlet UITextField *TXT_search;

@property(nonatomic,weak) IBOutlet UILabel *LBL_header;
@property(nonatomic,weak) IBOutlet UIButton *BTN_search;


@end
