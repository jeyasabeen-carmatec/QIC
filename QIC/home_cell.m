//
//  home_cell.m
//  QIC
//
//  Created by anumolu mac mini on 19/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "home_cell.h"

@implementation home_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGRect frameset = _LBL_name.frame;
    frameset.origin.y = _IMG_name.frame.origin.y + _IMG_name.frame.size.height - 70;
    frameset.size.height = 60;
    _LBL_name.frame = frameset;
    
    _LBL_name.backgroundColor = [UIColor blackColor];
    _LBL_name.alpha = 0.5;
}

@end
