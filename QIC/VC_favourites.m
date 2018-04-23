//
//  VC_providers.m
//  QIC
//
//  Created by anumolu mac mini on 06/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_favourites.h"
#import"favourites_cell.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>




@interface VC_favourites ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_images;
    NSDictionary *jsonresponse_DIC;
}

@end

@implementation VC_favourites

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_images = [NSArray arrayWithObjects:@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg", nil];
    [_BTN_bcak addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
    
  //  [APIHelper start_animation:self];
    [self performSelector:@selector(favourites_API_call) withObject:nil afterDelay:0.01];

}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if([[jsonresponse_DIC valueForKey:@"List"] isKindOfClass:[NSArray class]])
    {
        count = [[jsonresponse_DIC valueForKey:@"List"] count];
    }
    else{
        count = 0;
    }
    return count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    favourites_cell *cell = (favourites_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"favourites_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    @try
    {
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:indexPath.section] valueForKey:@"provider_name"]]];
    str_name = [str_name uppercaseString];
    
    
    cell.LBL_name.text = [NSString stringWithFormat:@"%@",str_name];
    
    NSString *str_designation = [NSString stringWithFormat:@"Services : %@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:indexPath.section] valueForKey:@"service_name"]]];
    
    cell.LBL_designnantion.text = [NSString stringWithFormat:@"%@",str_designation];
    
    NSString *str_address = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:indexPath.section] valueForKey:@"address"]]];
    
    cell.LBL_addres.text = [NSString stringWithFormat:@"%@",str_address];

    NSString *str_dicount_type = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:indexPath.section] valueForKey:@"offer_type"]];
        
         NSString *str_dicount = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:indexPath.section] valueForKey:@"offer_value"]];
        
    if([str_dicount_type isEqualToString:@"Percentage"])
    {
        NSString *str = @"%";
        float str_va = [str_dicount floatValue];
        str_dicount = [NSString stringWithFormat:@"%.f",str_va];
        str_dicount = [NSString stringWithFormat:@"%@%@\ndiscount",str_dicount,str];
    }
    else{
        str_dicount = [NSString stringWithFormat:@"%@",str_dicount];
    }
    

    [cell.BTN_favourite addTarget:self action:@selector(delete_ITEM_from_Wish_list:) forControlEvents:UIControlEventTouchUpInside];
    cell.BTN_favourite.tag = indexPath.section;
    
    cell.BTN_favourite.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.78 alpha:1.0];
    
    NSString *str_addres = [NSString  stringWithFormat:@"%@",str_dicount];
    
    if ([cell.LBL_price_amount respondsToSelector:@selector(setAttributedText:)])
    {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:cell.LBL_price_amount.textColor,
                                  NSFontAttributeName: cell.LBL_price_amount.font,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_addres attributes:attribs];
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        float size;
        if(result.height <= 480)
        {
            size = 13.0;
        }
        else if(result.height <= 568)
        {
            size = 14.0;
        }
        else
        {
            size = 15.0;
        }
        
        cell.LBL_price_amount.font = [UIFont fontWithName:@"Futura-Heavy" size:size];
        @try
        {

        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Heavy" size:size],NSForegroundColorAttributeName:[UIColor colorWithRed:0.33 green:0.72 blue:0.78 alpha:1.0],}range:[str_addres rangeOfString:str_dicount] ];
        }
        @catch(NSException *exception)
        {
            NSLog(@"Exception for attributed text:%@",exception);
        }
        
        cell.LBL_price_amount.attributedText = attributedText;
    }
    else{
        cell.LBL_price_amount.text = str_addres;
    }
    
    cell.LBL_price_amount.transform=CGAffineTransformMakeRotation( ( 90 * M_PI ) / -360 );

    cell.VW_back_ground.layer.cornerRadius = 2.0f;
    }
    @catch(NSException *exception)
    {
        
    }
   
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
#pragma Back action
-(void)back_actions
{
    NSString *str_page = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];
    [self.delegate favourites_back_ACTION:str_page];
}

#pragma Faourites API call
-(void)favourites_API_call
{
    
    NSString *str_URL = [NSString stringWithFormat:@"%@getFavList",SERVER_URL];
    @try
    {
        NSString  *str_member_ID = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
     
        
        NSDictionary *TEMP_dict = @{@"customer_id":str_member_ID};
        
        NSDictionary *parameters = TEMP_dict;
        [APIHelper postServiceCall:str_URL andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
            }

            if(data)
            {
                NSLog(@"%@", jsonresponse_DIC);
                jsonresponse_DIC= data;
                if([[jsonresponse_DIC valueForKey:@"List"] isKindOfClass:[NSArray class]])
                {
                    [APIHelper stop_activity_animation:self];

                     dispatch_async(dispatch_get_main_queue(), ^{
                    [_TBL_list reloadData];
                     });
                    
                }
                
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{

                    [APIHelper stop_activity_animation:self];
                    NSString *str_page = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];

                    [self.delegate favourites_back_ACTION:str_page];
                    [APIHelper createaAlertWithMsg:@"No items found" andTitle:@""];
                         });
                }
                NSLog(@"The login customer Data:%@",jsonresponse_DIC);
                
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
    }

}

#pragma Delte Item from wish list
-(void)delete_ITEM_from_Wish_list:(UIButton *)sender
{
    
   // [APIHelper start_animation:self];
    NSString *str_URL = [NSString stringWithFormat:@"%@delFromFav",SERVER_URL];
    
    @try
    {
        NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
        NSString *srm_provider_ID = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:sender.tag] valueForKey:@"provider_id"]];
        
        NSString *service_ID = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"List"] objectAtIndex:sender.tag] valueForKey:@"services_id"]];

        
        NSDictionary *TEMP_dict = @{@"provider_id":srm_provider_ID,@"customer_id":str_member_ID,@"service_id":service_ID};
        
        NSDictionary *parameters = TEMP_dict;
        [APIHelper updateServiceCall:str_URL andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
            }
            if(data)
            {
               
                
                NSDictionary *temp_dict = data;
                [APIHelper stop_activity_animation:self];
                NSString *str_code = [NSString stringWithFormat:@"%@",[temp_dict valueForKey:@"msg"]];
                if([str_code isEqualToString:@"Sucess"])
                {
                    [APIHelper createaAlertWithMsg:@"Offer deleted from your favourites." andTitle:@""];
                    int i = [[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"] intValue];
                    NSString *str_count;
                    if(i == 0 )
                    {
                        i = 0;
                    }
                    else
                    {
                        i = i - 1;
                        str_count = [NSString stringWithFormat:@"%d",i];
                    }
                    [[NSUserDefaults standardUserDefaults] setValue:str_count forKey:@"wish_count"];
                    [[NSUserDefaults standardUserDefaults] synchronize];

                    [self favourites_API_call];

                    
                }
                else{
                    [APIHelper stop_activity_animation:self];
                    [APIHelper createaAlertWithMsg:@"Something went wrong." andTitle:@""];
                    
                }
                
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
    }
    
    
    
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
