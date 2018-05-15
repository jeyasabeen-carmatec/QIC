//
//  favourites_cell.m
//  QIC
//
//  Created by anumolu mac mini on 06/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "favourites_cell.h"

@implementation favourites_cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _IMG_provider.layer.cornerRadius = _IMG_provider.frame.size.width/2;
    _IMG_provider.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
