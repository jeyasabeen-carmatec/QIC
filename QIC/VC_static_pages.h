//
//  VC_static_pages.h
//  QIC
//
//  Created by anumolu mac mini on 20/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"


@interface VC_static_pages : UIViewController
@property(nonatomic,weak) IBOutlet UIWebView *about_us_VW;
@property(nonatomic,weak) IBOutlet UILabel *LBL_header;
@property(nonatomic,weak) IBOutlet UIButton *BTN_back;;


#pragma delegate calling

@property(nonatomic,assign) id <home_page_protocols> delegate;

@end
