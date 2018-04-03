//
//  homw_tab_bar.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "homw_tab_bar.h"

@implementation homw_tab_bar

#define kTabBarHeight  50// Input the height we want to set for Tabbar here
-(CGSize)sizeThatFits:(CGSize)size
{
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = kTabBarHeight;
    
    return sizeThatFits;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
