//
//  TXT_with_out_x.m
//  QIC
//
//  Created by anumolu mac mini on 23/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "TXT_with_out_x.h"

@implementation TXT_with_out_x

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(10, bounds.origin.y, bounds.size.width-5, bounds.size.height);
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(10, bounds.origin.y, bounds.size.width-5, bounds.size.height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
