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
    CGSize result = [[UIScreen mainScreen] bounds].size;
    float ht,origin;
    if(result.height <= 480)
    {
        ht = 40;
        origin = 50;
    }
    else if(result.height <= 568)
    {
        ht= 40;
        origin = 50;
    }
    else
    {
        ht = 60;
        origin = 70;
        
    }
    
    frameset.origin.y = _IMG_name.frame.origin.y + _IMG_name.frame.size.height - origin;

    frameset.size.height = ht;
    _LBL_name.frame = frameset;
    
    _LBL_name.backgroundColor = [UIColor blackColor];
    _LBL_name.alpha = 0.5;
}

@end
