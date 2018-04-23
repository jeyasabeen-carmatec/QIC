//
//  VC_search.h
//  QIC
//
//  Created by anumolu mac mini on 23/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"



@interface VC_search : UIViewController


#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;


#pragma Search bar views

@property(nonatomic,weak) IBOutlet UILabel *LBL_search_place_holder;
@property(nonatomic,weak) IBOutlet UITextField *TXT_search;
@property(nonatomic,weak) IBOutlet UIButton *BTN_back;

@property(nonatomic,weak) IBOutlet UIButton *BTN_search;

#pragma delegate calling

@property(nonatomic,assign) id <home_page_protocols> delegate;
@end
