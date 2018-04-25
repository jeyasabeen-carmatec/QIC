//
//  news_cell.h
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface news_cell : UITableViewCell

@property(nonatomic,weak) IBOutlet UIImageView *IMG_title;
@property(nonatomic,weak) IBOutlet UILabel *LBL_name;
@property(nonatomic,weak) IBOutlet UILabel *LBL_address;
@property(nonatomic,weak) IBOutlet UILabel *LBL_company;

@end
