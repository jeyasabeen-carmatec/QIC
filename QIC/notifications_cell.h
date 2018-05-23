//
//  notifications_cell.h
//  QIC
//
//  Created by anumolu mac mini on 17/05/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notifications_cell : UITableViewCell
@property(nonatomic,weak) IBOutlet UILabel *LBL_text;
@property(nonatomic,weak) IBOutlet UIView *VW_background;
@property(nonatomic,weak) IBOutlet UILabel *LBL_title;
@property(nonatomic,weak) IBOutlet UILabel *LBL_date;



@end
