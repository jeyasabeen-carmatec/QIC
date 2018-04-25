//
//  TXT_placeholder.m
//  QIC
//
//  Created by anumolu mac mini on 06/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "TXT_placeholder.h"

@implementation TXT_placeholder


- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(30, bounds.origin.y, bounds.size.width-5, bounds.size.height);
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectMake(30, bounds.origin.y, bounds.size.width-5, bounds.size.height);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
