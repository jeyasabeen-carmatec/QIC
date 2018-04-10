//
//  VC_home_tab.h
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"


@interface VC_home_tab : UIViewController

#pragma Table view
@property(nonatomic,weak) IBOutlet UITableView *TBL_list;

#pragma Favourites Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_favourite;

#pragma Delegate action
@property(nonatomic,assign) id <home_page_protocols> delegate;

#pragma Scroll view

@property(nonatomic,weak) IBOutlet UIScrollView *Scroll_contents;

#pragma list of providers

@property(nonatomic,weak) IBOutlet UIView *VW_providers;
//@property(nonatomic,weak) IBOutlet UIView *VW_indicagtor_for_cover;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_providers;



#pragma list of offers
@property(nonatomic,weak) IBOutlet UIView *VW_offers;
//@property(nonatomic,weak) IBOutlet UIView *VW_offer_indicator_for_cover;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_offers;


#pragma list of News
@property(nonatomic,weak) IBOutlet UIView *VW_news;
//@property(nonatomic,weak) IBOutlet UIView *VW_news_indicator_for_cover;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_News;


#pragma Search bar views

@property(nonatomic,weak) IBOutlet UILabel *LBL_search_place_holder;
@property(nonatomic,weak) IBOutlet UITextField *TXT_search;




@end
