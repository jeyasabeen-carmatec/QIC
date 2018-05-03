//
//  homw_tab_bar.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "homw_tab_bar.h"

@implementation homw_tab_bar
{
    UIEdgeInsets oldSafeAreaInsets;
}

#define kTabBarHeight  50// Input the height we want to set for Tabbar here
//-(CGSize)sizeThatFits:(CGSize)size
//{
//    CGSize sizeThatFits = [super sizeThatFits:size];
//    sizeThatFits.height = kTabBarHeight;
//    
//    return sizeThatFits;
//}
- (void)safeAreaInsetsDidChange {
    [super safeAreaInsetsDidChange];
    
    if (!UIEdgeInsetsEqualToEdgeInsets(oldSafeAreaInsets, self.safeAreaInsets)) {
        [self invalidateIntrinsicContentSize];
        
        if (self.superview) {
            [self.superview setNeedsLayout];
            [self.superview layoutSubviews];
        }
    }
}

- (CGSize)sizeThatFits:(CGSize)size {
    size = [super sizeThatFits:size];
    
    if (@available(iOS 11.0, *)) {
        float bottomInset = self.safeAreaInsets.bottom;
        if (bottomInset > 0 && size.height < 50 && (size.height + bottomInset < 90)) {
            size.height += bottomInset;
        }
    }
    
    return size;
}


- (void)setFrame:(CGRect)frame {
    if (self.superview) {
        if (frame.origin.y + frame.size.height != self.superview.frame.size.height)
        {
            CGSize screenSize = [[UIScreen mainScreen] bounds].size;
            if (screenSize.height == 812.0f)
                frame.origin.y = self.superview.frame.size.height - frame.size.height +20;
            else
                frame.origin.y = self.superview.frame.size.height - frame.size.height;


           
        }
    }
    [super setFrame:frame];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
