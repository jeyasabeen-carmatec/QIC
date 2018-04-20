//
//  VC_health_card.m
//  QIC
//
//  Created by anumolu mac mini on 19/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_health_card.h"

@interface VC_health_card ()

@end

@implementation VC_health_card

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frameset = _IMG_profile.frame;
    frameset.origin.x = _IMG_card.frame.size.width - _IMG_profile.frame.size.width /2 +20;
    _IMG_profile.frame = frameset;
    
    NSString *string = @"12345678912";
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < [string length]; i += 4)
        [array addObject:[string substringWithRange:NSMakeRange(i, MIN(4, [string length] - i))]];
    NSString *result = [array componentsJoinedByString:@" "];
    

       _LBL_card_number.text = [NSString stringWithFormat:@"%@",result];

    
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
}
-(void)back_action
{
    [self.delegate calling_profile_view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
