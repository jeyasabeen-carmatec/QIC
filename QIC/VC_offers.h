//
//  VC_offers.h
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_offers : UIViewController

#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;
#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;


@end
