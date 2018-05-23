//
//  VC_health_card.m
//  QIC
//
//  Created by anumolu mac mini on 19/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_health_card.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface VC_health_card ()

@end

@implementation VC_health_card

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect frameset = _IMG_profile.frame;
  //  frameset.origin.x = _IMG_card.frame.size.width - _IMG_profile.frame.size.width /2 +20;
    _IMG_profile.frame = frameset;
    
    @try
    {
        //NSString *str_image_URL = [[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"];
        NSString *str_image = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_NAME"]];
        str_image = [APIHelper convert_NUll:str_image];
        
        str_image = [str_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        [_IMG_profile sd_setImageWithURL:[NSURL URLWithString:str_image]
                          placeholderImage:[UIImage imageNamed:@""]];

    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
    
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
   NSDictionary  *TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"memberName"]];
    str_name = [APIHelper convert_NUll:str_name];
    _LBL_name.text = str_name;
    
   
    
    NSString * str_to_date = [NSString stringWithFormat:@"%@",[self getting_to_date:[[TEMP_dict valueForKey:@"validityToDate"] doubleValue]]];
    
    NSString *str_validity = [NSString stringWithFormat:@"Expiry : %@",str_to_date];
    _LBL_expiry_date.text = str_validity;
    
    
    
    
    NSString *str_id = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"membershipNo"]];
    str_id = [APIHelper convert_NUll:str_id];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i < [str_id length]; i += 4)
        [array addObject:[str_id substringWithRange:NSMakeRange(i, MIN(4, [str_id length] - i))]];
    NSString *result = [array componentsJoinedByString:@" "];
    

       _LBL_card_number.text = [NSString stringWithFormat:@"%@",result];

    
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
    }
    @catch(NSException *exception)
    {
        
    }
}
-(void)back_action
{
    [self.delegate calling_profile_view];
}
-(NSString*)getting_to_date:(double )timeStamp{
    NSTimeInterval timeInterval=timeStamp/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString=[dateformatter stringFromDate:date];
    return dateString;
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
