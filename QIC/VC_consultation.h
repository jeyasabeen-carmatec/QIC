//
//  VC_consultation.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_consultation : UIViewController


#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;

#pragma Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_bcak;

#pragma delegate calling

@property(nonatomic,assign) id <home_page_protocols> delegate;



@end
