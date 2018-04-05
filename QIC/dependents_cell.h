//
//  dependents_cell.h
//  QIC
//
//  Created by anumolu mac mini on 05/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface dependents_cell : UITableViewCell

#pragma labels
@property(nonatomic,weak) IBOutlet UILabel *LBL_dependent_name;
@property(nonatomic,weak) IBOutlet UILabel *LBL_relation;
@property(nonatomic,weak) IBOutlet UILabel *LBL_QID;
@property(nonatomic,weak) IBOutlet UILabel *LBL_member_ID;
@property(nonatomic,weak) IBOutlet UILabel *LBL_validity;

#pragma View backgroumd
@property(nonatomic,weak) IBOutlet UIView *VW_back_ground;

@end
