//
//  consultation_cell.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface consultation_cell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView *IMG_title;
@property(nonatomic,weak) IBOutlet UILabel *LBL_name;
@property(nonatomic,weak) IBOutlet UILabel *LBL_designnantion;
@property(nonatomic,weak) IBOutlet UILabel *LBL_addres;
@property(nonatomic,weak) IBOutlet UILabel *LBL_discount;


@property(nonatomic,weak) IBOutlet UIView *VW_back_ground;

@property(nonatomic,weak) IBOutlet UILabel *LBL_cost;

@property(nonatomic,weak)IBOutlet UIButton *BTN_favourite;

@end
