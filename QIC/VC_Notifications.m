//
//  VC_Notifications.m
//  QIC
//
//  Created by anumolu mac mini on 17/05/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_Notifications.h"
#import "notifications_cell.h"
#import "UITableView+NewCategory.h"
#import "APIHelper.h"
@class FrameObservingViewnotifications;

@protocol FrameObservingViewDelegatenotify <NSObject>
- (void)frameObservingViewFrameChanged:(FrameObservingViewnotifications *)view;
@end

@interface FrameObservingViewnotifications : UIView
@property (nonatomic,assign) id<FrameObservingViewDelegatenotify>delegate;
@end

@implementation FrameObservingViewnotifications
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.delegate frameObservingViewFrameChanged:self];
}
@end

@interface VC_Notifications ()<UITableViewDelegate,UITableViewDataSource,FrameObservingViewDelegatenotify,UITableViewDragLoadDelegate>
{
    CGRect old_txt_frame,button_search_frame;
    NSString *URL_STR;
    int page_count;
    NSMutableArray *arr_total_data,*CPY_arr;
    NSDictionary *jsonresponse_DIC,*temp_dict;
}
@end
@implementation VC_Notifications
- (void)frameObservingViewFrameChanged:(FrameObservingViewnotifications *)view
{
    _TBL_notifications.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_BTN_back addTarget:self action:@selector(back_ACTION) forControlEvents:UIControlEventTouchUpInside];
    arr_total_data = [[NSMutableArray alloc]init];
    CPY_arr = [[NSMutableArray alloc]init];
    old_txt_frame = _TXT_search.frame;
    button_search_frame = _BTN_search.frame;
    [_TBL_notifications setDragDelegate:self refreshDatePermanentKey:@"FriendList"];
    _TBL_notifications.showLoadMoreView = YES;
    [_BTN_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventTouchUpInside];
    [APIHelper start_animation:self];
    [self performSelector:@selector(notifications_LIST_API) withObject:nil afterDelay:0.01];
    
    temp_dict = [[NSUserDefaults standardUserDefaults]  valueForKey:@"notification_DICT"];
    //  NSString *str_dict = [NSString stringWithFormat:@"%@",temp_dict];
    
    if(temp_dict)
    {
        //   [APIHelper createaAlertWithMsg:str_dict andTitle:@""];
        [self TXT_view_setting];
       
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"notification_DICT"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         _TXT_view.text =[NSString stringWithFormat:@"%@",[[[temp_dict valueForKey:@"aps"]valueForKey:@"alert"]valueForKey:@"body"]];
        [self  search_bar_hide];
    }
    
}
-(void)TXT_view_setting;
{
    _TBL_notifications.hidden = YES;
    CGRect frameset = _TXT_view.frame;
    frameset.origin.x = 10;
    frameset.origin.y = _TXT_search.frame.origin.y + _TXT_search.frame.size.height + 10;
    
    frameset.size.height = self.view.frame.size.height - _TXT_view.frame.origin.y;
//    float ht = self.view.frame.size.height - _TXT_view.frame.origin.y;
//    if(ht == frameset.size.height)
//    {
//        frameset.size.height = ht;
//
//    }
//
    frameset.size.width = self.view.frame.size.width - 25;
    _TXT_view.frame = frameset;
    
    [self.view addSubview:_TXT_view];
    
}
#pragma back action
-(void)back_ACTION
{
    if(_TBL_notifications.hidden == YES)
    {
        _TBL_notifications.hidden = NO;
        _TXT_view.hidden = YES;
         [self  search_bar_hide];
       
    }
    else
    {
        [self.delegate notification_back];
    }
    [_TXT_search resignFirstResponder];
    
}
-(void)search_bar_hide
{
    if(_TXT_view.hidden == YES)
    {
        _TXT_search.hidden = NO;
        _LBL_search_place_holder.hidden = NO;
        _BTN_search.hidden = NO;
    }
    else{
        
        _TXT_search.hidden = YES;
        _LBL_search_place_holder.hidden = YES;
        _BTN_search.hidden = YES;
        
    }
}
#pragma mark table view delagtes
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_total_data.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    notifications_cell *cell = (notifications_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"notifications_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.VW_background.layer.cornerRadius = 4.0f;
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSString *str_text = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section]valueForKey:@"title"]]];
    cell.LBL_text.text =[NSString stringWithFormat:@"%@",str_text];
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self DELETE_notification:[[arr_total_data objectAtIndex:indexPath.row]valueForKey:@"id"]];
       
    }
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
    _TXT_view.hidden = NO;
    NSString *str_text = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section]valueForKey:@"message"]]];
     NSString *str_status = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[arr_total_data objectAtIndex:indexPath.section]valueForKey:@"type"]]];
//    if([str_status isEqualToString:@"provider"])
//    {
        _TXT_view.text = str_text;
        [self TXT_view_setting];
        [self search_bar_hide];
//    }
//    else
//    {
//        NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"]];
//        NSString *str_URL = [NSString stringWithFormat:@"%@%@",str_image_base_URl,[[arr_total_data objectAtIndex:indexPath.row] valueForKey:@"url_key"]];
//        [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];
//
//        [[NSUserDefaults standardUserDefaults]  setValue:@"TOP ARTICLES" forKey:@"header_val"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        [self.delegate calling_news_view:@"news_detail"];
  //  }
    
    
    
}
#pragma textfield delgates

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
    frameset.origin.x = _LBL_search_place_holder.frame.size.width + 20;
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *myString = _TXT_search.text;
    NSString *myNewString = [myString stringByReplacingOccurrencesOfString:@"\\s  "
                                                                withString:@""
                                                                   options:NSRegularExpressionSearch
                                                                     range:NSMakeRange(0, [myString length])];
    
    _TXT_search.text = myNewString;
    
    return YES;
}
#pragma API call for Notification list

-(void)notifications_LIST_API
{
    @try
    {
    NSHTTPURLResponse *response = nil;
    NSError *error;
   NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
//    NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"service_ID"]];
    NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
    URL_STR = [NSString stringWithFormat:@"%@notificationList/%@/1/%@",str_image_base_URl,str_member_ID,@""];
    URL_STR = [URL_STR stringByReplacingOccurrencesOfString:@"" withString:@"%20"];
    
    
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
            [_TBL_notifications reloadData];
            
        }
        else
        {
            [APIHelper createaAlertWithMsg:@"No offers found." andTitle:nil];
           // [self.delegate consultation_offers_back:@""];
            
        }
        
        
        
        
    }
    else
    {
        NSDictionary *dictin = [[NSDictionary alloc]initWithObjectsAndKeys:@"Nodata",@"error", nil];
        NSLog(@"%@",dictin);
    }
}
@catch(NSException *Exception)
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
//            NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"service_ID"]];
            NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
            
            
            NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
            
          NSString  *str_url = [NSString stringWithFormat:@"%@notificationList/%@/%d/%@",str_image_base_URl,str_member_ID,page_count,_TXT_search.text];

        
            str_url = [str_url stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            str_url = [str_url stringByReplacingOccurrencesOfString:@"" withString:@"%20"];
            
            
            
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
                        [_TBL_notifications reloadData];
                        
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
           // [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
        }
        @catch(NSException *exception)
        {
            
        }
        
    }
    else
    {
        [arr_total_data addObjectsFromArray:CPY_arr];
        [_TBL_notifications reloadData];
    }
    
}
#pragma mark delete Notification
-(void)DELETE_notification:(NSString *)str_notification_ID
{
    @try
    {
        
        
      //  NSString *str_QID = [NSString stringWithFormat:@"%@",_TXT_uname.text];
        NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
        NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
        
        NSString *url_str = [NSString stringWithFormat:@"%@delNotification",str_image_base_URl];
        //   NSString *str_Phone =[NSString stringWithFormat:@"%@",_TXT_password.text];
        NSDictionary *parameters =@{
            @"customer_id":str_member_ID,
            @"notification_id":str_notification_ID
            };
        [APIHelper postServiceCall:url_str andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                
            }
            if(data)
            {
                NSDictionary *TEMP_dict = [data valueForKey:@"data"];
                NSLog(@"The login customer Data:%@",TEMP_dict);
                [APIHelper stop_activity_animation:self];
                
               
                
                
            }
            else{
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
    }

}
#pragma mark - Control datasource
- (void)finishRefresh
{
    [_TBL_notifications finishRefresh];
}

- (void)finishLoadMore
{
    [_TBL_notifications finishLoadMore];
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
            
            [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
            
        }
        else
        {
            
            page_count =  page_count  + 1;
//            NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"service_ID"]];
//
            NSString *url_STR = URL_STR;
            NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
             NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
            url_STR = [NSString stringWithFormat:@"%@notificationList/%@/%d/%@",str_image_base_URl,str_member_ID,page_count,_TXT_search.text];

//            url_STR = [NSString stringWithFormat:@"%@getProviderstByServiceId/%@/%d/%@",SERVER_URL,str_id,page_count,str_member_ID];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Sorry no more offers found." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
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
                        [_TBL_notifications reloadData];
                        
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
