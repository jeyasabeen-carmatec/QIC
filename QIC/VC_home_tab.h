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
@property(nonatomic,weak) IBOutlet UIImageView *IMG_providers;
@property(nonatomic,weak) IBOutlet UIButton *BTN_providers_all;
@property(nonatomic,weak) IBOutlet UILabel *LBL_provider_header_label;

@property(nonatomic,weak) IBOutlet UICollectionView *collection_providers;
@property(nonatomic,weak) IBOutlet UIButton *BTN_provide_left;
@property(nonatomic,weak) IBOutlet UIButton *BTN_provide_right;

#pragma list of offers
@property(nonatomic,weak) IBOutlet UIView *VW_offers;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_offers;
@property(nonatomic,weak) IBOutlet UILabel *LBL_offer_header_label;
@property(nonatomic,weak) IBOutlet UIButton *BTN_offers_all;


@property(nonatomic,weak) IBOutlet UICollectionView *collection_offers;
@property(nonatomic,weak) IBOutlet UIButton *BTN_offers_left;
@property(nonatomic,weak) IBOutlet UIButton *BTN_offers_right;



#pragma list of News
@property(nonatomic,weak) IBOutlet UIView *VW_news;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_News;
@property(nonatomic,weak) IBOutlet UILabel *LBL_news_header_label;
@property(nonatomic,weak) IBOutlet UIButton *BTN_news_all;

@property(nonatomic,weak) IBOutlet UICollectionView *collection_news;
@property(nonatomic,weak) IBOutlet UIButton *BTN_news_left;
@property(nonatomic,weak) IBOutlet UIButton *BTN_news_right;



#pragma Search bar views

@property(nonatomic,weak) IBOutlet UILabel *LBL_search_place_holder;
@property(nonatomic,weak) IBOutlet UITextField *TXT_search;


#pragma mark Notification button
@property(nonatomic,weak) IBOutlet UIButton *BTN_notification;



@end
