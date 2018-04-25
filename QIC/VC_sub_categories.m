//
//  VC_sub_categories.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_sub_categories.h"
#import "news_cell.h"
#import "subcategory_cell.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITableView+NewCategory.h"

@class FrameObservingView;

@protocol FrameObservingViewDelegate <NSObject>
- (void)frameObservingViewFrameChanged:(FrameObservingView *)view;
@end

@interface FrameObservingView : UIView
@property (nonatomic,assign) id<FrameObservingViewDelegate>delegate;
@end

@implementation FrameObservingView
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.delegate frameObservingViewFrameChanged:self];
}
@end


@interface VC_sub_categories ()
<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FrameObservingViewDelegate,UITableViewDragLoadDelegate>
{
    NSMutableArray *arr_total_data,*CPY_arr;
     NSDictionary *jsonresponse_DIC;
    NSString *URL_STR;
    CGRect old_txt_frame,button_search_frame;
    int page_count;
}


@end

@implementation VC_sub_categories
- (void)frameObservingViewFrameChanged:(FrameObservingView *)view
{
    _TBL_list.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page_count = 1;
    arr_total_data = [[NSMutableArray alloc]init];
    CPY_arr = [[NSMutableArray alloc]init];
    
    old_txt_frame = _TXT_search.frame;
    button_search_frame = _BTN_search.frame;
    [_TBL_list setDragDelegate:self refreshDatePermanentKey:@"FriendList"];
    _TBL_list.showLoadMoreView = YES;
    [_BTN_bcak addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
   // [_TXT_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventEditingChanged];
    [_BTN_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventTouchUpInside];

    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];

    [APIHelper start_animation:self];
    [self performSelector:@selector(SUB_Categiries_API_CALL) withObject:nil afterDelay:0.01];

}
#pragma Table view delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    @try
    {
    return arr_total_data.count;
    }
    @catch(NSException *exception)
    {
        
    }
    
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
        _LBL_header.text = [NSString stringWithFormat:@"%@ PROVIDERS",[APIHelper convert_NUll:[[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"provider_type"] uppercaseString]]];
        
        
        NSString *str_designation;
        if([[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"specialities"] isKindOfClass:[NSArray class]])
        {
            str_designation = @"Not mentioned";
        }
        else
        {
        
          str_designation = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"specialities"]]];
        }
        
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
        str_image = [str_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

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
    @try
    {
    
    [self.delegate detail_page_visibility:@"subcategory_detail"];
    [[NSUserDefaults standardUserDefaults] setObject:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"id"] forKey:@"category_ID"];
    [[NSUserDefaults standardUserDefaults] setObject:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"provider_id"] forKey:@"provider_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
    @catch(NSException *exception)
    {
    }
}

#pragma back action
-(void)back_actions
{
    [_TXT_search resignFirstResponder];

    [self.delegate subcategories_back_action:@"back"];
}
#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
#pragma Textfield Delegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frameset = _LBL_search_place_holder.frame;
    frameset.size.width = _LBL_search_place_holder.frame.size.width - 40;
    _LBL_search_place_holder.frame = frameset;
    
    frameset = _TXT_search.frame;
    frameset.size.width = _TXT_search.frame.size.width - 40;
    _TXT_search.frame = frameset;

    
    frameset = _BTN_search.frame;
    frameset.origin.x = _LBL_search_place_holder.frame.size.width + 15;
    _BTN_search.frame = frameset;
    
  
    
    _LBL_search_place_holder.alpha = 0.0f;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
      _LBL_search_place_holder.frame = old_txt_frame;
     _TXT_search.frame =  old_txt_frame;
      _BTN_search.frame = button_search_frame;
    
    _TXT_search.text = @"";

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

#pragma mark Mobile _call

-(void)mobile_dial:(UIButton *)sender
{
    NSString *phone_number;
    @try
    {
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
#pragma Categorie Providers

-(void)SUB_Categiries_API_CALL
{
   @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"catgory_id"]];
       URL_STR = [NSString stringWithFormat:@"%@getProviderstByProviderId/%@/1",SERVER_URL,str_id];
        
        NSURL *urlProducts=[NSURL URLWithString:URL_STR];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:urlProducts];
        [request setHTTPMethod:@"GET"];
        [request setHTTPShouldHandleCookies:NO];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [APIHelper stop_activity_animation:self];
        
        if(aData)
        {
            jsonresponse_DIC =(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            NSLog(@"%@",jsonresponse_DIC);
         
            if([[jsonresponse_DIC valueForKey:@"List"] isKindOfClass:[NSArray class]])
            {
                [arr_total_data addObjectsFromArray:[jsonresponse_DIC valueForKey:@"List"]];
                [_TBL_list reloadData];


            }
            else{
                [self.delegate subcategories_back_action:@"back"];
                [APIHelper createaAlertWithMsg:@"No providers found." andTitle:nil];

            }
            
            
            
            
        }
        else
        {
            [APIHelper createaAlertWithMsg:@"Connection error" andTitle:nil];

        }
    }
    @catch(NSException *Exception)
    {
        
    }
    
}
#pragma mark - Control datasource
- (void)finishRefresh
{
    [_TBL_list finishRefresh];
}

- (void)finishLoadMore
{
    [_TBL_list finishLoadMore];
}

#pragma mark - Drag delegate methods
- (void)dragTableDidTriggerRefresh:(UITableView *)tableView
{
    //Pull up go to First Page
    [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:0.01];
    
}

- (void)dragTableRefreshCanceled:(UITableView *)tableView
{
    //cancel refresh request(generally network request) here
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishRefresh) object:nil];
}

- (void)dragTableDidTriggerLoadMore:(UITableView *)tableView
{
    //Pull up go to NextPage
    
    @try
    {
        NSString *int_VAL = [NSString stringWithFormat:@"%@",[jsonresponse_DIC valueForKey:@"totalRecords"]];
        NSLog(@"The products Count:%lu",(unsigned long)[arr_total_data count]);
        
        if([int_VAL intValue] == [arr_total_data count])
        {
            [APIHelper stop_activity_animation:self];
            
            NSString *str_status = @"Sorry no more providers found";
            NSString *str_ok = @"Ok";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:str_status delegate:self cancelButtonTitle:nil otherButtonTitles:str_ok, nil];
            [alert show];
            
            
            [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
            
        }
        else
        {
            
            page_count =  page_count  + 1;
            NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"catgory_id"]];
           
            NSString *url_STR = URL_STR;
            url_STR = [NSString stringWithFormat:@"%@getProviderstByProviderId/%@/%d",SERVER_URL,str_id,page_count];
            url_STR =  [url_STR stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:url_STR forKey:@"URL_SAVED"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self performSelector:@selector(NEXTpage_API) withObject:nil afterDelay:0.01];
        }
        
        
    }
    @catch (NSException *exception)
    {
        
    }
    
}

- (void)dragTableLoadMoreCanceled:(UITableView *)tableView
{
    //cancel load more request(generally network request) here
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(finishLoadMore) object:nil];
}

-(void) NEXTpage_API
{
    @try
    {
    NSError *error;
    NSHTTPURLResponse *response = nil;
    
    NSURL *urlProducts=[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"URL_SAVED"]]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:urlProducts];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (aData)
    {
        
        NSMutableDictionary *dict=(NSMutableDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
        if([[dict valueForKey:@"msg"] isEqualToString:@"Failure"])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No more providers found." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else{
        
        @try
        {
            if([[jsonresponse_DIC valueForKey:@"List"] isKindOfClass:[NSArray class]])
            {
            
            NSMutableArray *new_ARR = [[NSMutableArray alloc]init];
            new_ARR = [dict valueForKey:@"List"];
            [arr_total_data addObjectsFromArray:new_ARR];
            [_TBL_list reloadData];
            
            }
            
            
        }
        @catch (NSException *exception)
        {
            
        }
        
        }
        
    }
    else
    {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
          [alert show];
    }
     [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
     }
     @catch(NSException *exception)
     {
         
     }
     
    }

#pragma search_API_called

-(void)Search_API_called
{
    if(_TXT_search.text.length > 2)
    {
    
    @try
    {
        [APIHelper start_animation:self];
        NSError *error;
        NSHTTPURLResponse *response = nil;
         NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"catgory_id"]];
        
        NSString *str_url = [NSString stringWithFormat:@"%@getProviderstByProviderId/%@/%@/%@",SERVER_URL,str_id,@"1",_TXT_search.text];
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
                
                NSMutableArray *new_ARR = [[NSMutableArray alloc]init];
                new_ARR = [jsonresponse_DIC valueForKey:@"List"];
                [CPY_arr addObjectsFromArray:arr_total_data];
                [arr_total_data removeAllObjects];
                [arr_total_data addObjectsFromArray:new_ARR];
                [_TBL_list reloadData];
                
                }

                
                
            }
            @catch (NSException *exception)
            {
                
            }
            
            
            
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Connection Error" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
    }
    @catch(NSException *exception)
    {
        
    }
        
    }
    else
    {
        [arr_total_data addObjectsFromArray:CPY_arr];
        [_TBL_list reloadData];
    }

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
