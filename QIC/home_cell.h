//
//  home_cell.h
//  QIC
//
//  Created by anumolu mac mini on 19/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface home_cell : UICollectionViewCell

@property(nonatomic,weak)IBOutlet UILabel *LBL_name;
@property(nonatomic,weak)IBOutlet UIImageView *IMG_name;

@property(nonatomic,weak)IBOutlet UIView  *VW_background;

@end
