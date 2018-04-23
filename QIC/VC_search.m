//
//  VC_search.m
//  QIC
//
//  Created by anumolu mac mini on 23/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_search.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "subcategory_cell.h"

@interface VC_search ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *arr_total_data;
    NSDictionary *jsonresponse_DIC;
   

}
@end

@implementation VC_search

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    arr_total_data = [[NSMutableArray alloc]init];
    _TBL_list.delegate = self;
    _TBL_list.dataSource = self;
    //[_TXT_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventEditingChanged];
    [_BTN_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_back addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];

    _TBL_list.hidden = YES;

    // Do any additional setup after loading the view.
}
#pragma back_actions
-(void)back_actions
{
    NSString *str_page = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];
    
    [self.delegate provider_search_back:str_page];

}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return arr_total_data.count
    ;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      subcategory_cell *cell = (subcategory_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil)
        {
            NSArray *nib;
            nib = [[NSBundle mainBundle] loadNibNamed:@"subcategory_cell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        @try
        {
            cell.contentView.layer.cornerRadius = 2.0f;
            
            NSString *str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"provider_name"]]];
            str_name = [str_name uppercaseString];
            
            
            cell.LBL_name.text = [NSString stringWithFormat:@"%@",str_name];
            
            
            NSString *str_designation = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"specialities"]]];
            
            cell.LBL_designnantion.text = [NSString stringWithFormat:@"%@",str_designation];
            
            NSString *str_address = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"address"]]];
            
            cell.LBL_addres.text = [NSString stringWithFormat:@"%@",str_address];
            
            NSString *str_phone = [NSString stringWithFormat:@"%@",[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"contact_no"]];
            str_phone = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:str_phone]];
            
            
            str_phone = [NSString stringWithFormat:@"Ph : %@",str_phone];
            
            cell.LBL_phone.text = [NSString stringWithFormat:@"%@",str_phone];
            
            
            cell.VW_background.layer.cornerRadius = 2.0f;
            
            cell.IMG_title.layer.cornerRadius = cell.IMG_title.frame.size.width/2;
            cell.IMG_title.layer.masksToBounds = YES;
            
            
            NSString *str_image = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"logo"]]];
            
            [cell.IMG_title sd_setImageWithURL:[NSURL URLWithString:str_image]
                              placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
            
            cell.BTN_phone.tag = indexPath.section;
            
            [cell.BTN_phone addTarget:self action:@selector(mobile_dial:) forControlEvents:UIControlEventTouchUpInside];
            
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
    
    [self.delegate detail_page_visibility:@"subcategory_detail"];
    [[NSUserDefaults standardUserDefaults] setObject:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"id"] forKey:@"category_ID"];
    [[NSUserDefaults standardUserDefaults] setObject:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"provider_id"] forKey:@"provider_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma search_API_calling

-(void)Search_API_called
{
    if(_TXT_search.text.length > 2)
    {
          [APIHelper start_animation:self];
        
        @try
        {
            NSError *error;
            NSHTTPURLResponse *response = nil;
            
            NSString *str_url = [NSString stringWithFormat:@"%@getProvidersBysearch/%@/%@",SERVER_URL,_TXT_search.text,@"1"];
            str_url = [str_url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

            
            NSURL *urlProducts=[NSURL URLWithString:[NSString stringWithFormat:@"%@",str_url]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:urlProducts];
            [request setHTTPMethod:@"GET"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            [APIHelper stop_activity_animation:self];
            if (aData)
            {
                
                jsonresponse_DIC=(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
                
                @try
                {
                    if([[jsonresponse_DIC valueForKey:@"List"] isKindOfClass:[NSArray class]])
                    {
                    [arr_total_data addObjectsFromArray:[jsonresponse_DIC valueForKey:@"List"]];
                    [_TBL_list reloadData];
                    _TBL_list.hidden = NO;
                    }
                    else{
                        _TBL_list.hidden = YES;
                    }
                    
                    
                    
                    
                }
                @catch (NSException *exception)
                {
                    
                }
                
                
                
            }
            else
            {
                 _TBL_list.hidden = YES;
                
            }
        }
        @catch(NSException *exception)
        {
            
        }
    }
    else
        {
            _TBL_list.hidden = YES;
        }
        
    


}

#pragma mark Mobile _call

-(void)mobile_dial:(UIButton *)sender
{
    // NSIndexPath *buttonIndexPath1 = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    //  NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath1.row];
    NSString *phone_number;
    @try {
        phone_number =[NSString stringWithFormat:@"%@",[[arr_total_data objectAtIndex:sender.tag] valueForKey:@"contact_no"]];
        phone_number = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:phone_number]];
        
    } @catch (NSException *exception) {
        NSLog(@"No phone number available %@",exception);
    }
    
    if (phone_number) {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phone_number]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Phone number not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}
#pragma Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _LBL_search_place_holder.alpha = 0.0f;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if([textField.text isEqualToString:@""])
    {
        _LBL_search_place_holder.alpha = 1.0f;
    }
    else{
        _LBL_search_place_holder.alpha = 0.0f;
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
