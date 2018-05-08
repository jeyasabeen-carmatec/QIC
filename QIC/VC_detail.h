//
//  VC_detail.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "home_page_protocols.h"
#import <GoogleMaps/GoogleMaps.h>


@interface VC_detail : UIViewController
#pragma Scroll view
@property(nonatomic,weak) IBOutlet UIScrollView *scroll_contents;

#pragma View main components
@property(nonatomic,weak) IBOutlet UIView *VW_main;
@property(nonatomic,weak) IBOutlet UIView *sub_VW_main;

@property(nonatomic,weak) IBOutlet UIImageView *IMG_center_image;
@property(nonatomic,weak) IBOutlet UILabel *LBL_center_name;
@property(nonatomic,weak) IBOutlet UILabel *LBL_designation;
@property(nonatomic,weak) IBOutlet UILabel *LBL_address;
@property(nonatomic,weak) IBOutlet UILabel *LBL_phone;
@property(nonatomic,weak) IBOutlet UIView *VW_segment;
@property(nonatomic,weak) IBOutlet UIButton *BTN_call;
//@property(nonatomic,weak) IBOutlet UITextView *TXT_VW_address;


#pragma Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_back;

#pragma tableview 
@property(nonatomic,weak)IBOutlet UITableView *TBL_offers;


#pragma delegate calling

@property(nonatomic,assign) id <home_page_protocols> delegate;


#pragma mapview creation
@property(nonatomic,weak) IBOutlet  GMSMapView *mapView ;

#pragma Favourites Button
@property(nonatomic,weak) IBOutlet UIButton *BTN_favourite;

#pragma Get Direction button
@property(nonatomic,weak) IBOutlet UIButton *BTN_get_direction;

@property(nonatomic,weak) IBOutlet UILabel *LBL_header;

#pragma Empty view
@property(nonatomic,weak) IBOutlet UIView *VW_empty;


@end
