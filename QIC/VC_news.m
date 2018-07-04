//
//  VC_news.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_news.h"
#import "news_cell.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITableView+NewCategory.h"


@class FrameObservingViewnews;

@protocol FrameObservingViewDelegate2 <NSObject>
- (void)frameObservingViewFrameChanged:(FrameObservingViewnews *)view;
@end

@interface FrameObservingViewnews : UIView
@property (nonatomic,assign) id<FrameObservingViewDelegate2>delegate;
@end

@implementation FrameObservingViewnews
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self.delegate frameObservingViewFrameChanged:self];
}
@end

@interface VC_news ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,FrameObservingViewDelegate2,UITableViewDragLoadDelegate>
{
    NSMutableArray *ARR_total_data,*CPY_ARR;
    NSDictionary *jsonresponse_DIC;
    CGRect old_txt_frame,button_search_frame;
    int page_count;
     NSString *URL_STR;

}


@end

@implementation VC_news

- (void)frameObservingViewFrameChanged:(FrameObservingViewnews *)view
{
    _TBL_list.frame = self.view.bounds;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self CountAvailableNotification_API];
    page_count = 1;
    ARR_total_data = [[NSMutableArray alloc]init];
    CPY_ARR = [[NSMutableArray alloc]init];
    old_txt_frame = _TXT_search.frame;
    button_search_frame = _BTN_search.frame;
    
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];
   // [_TXT_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventEditingChanged];
    [_BTN_search addTarget:self action:@selector(Search_API_called) forControlEvents:UIControlEventTouchUpInside];

    [APIHelper start_animation:self];
    [self performSelector:@selector(News_API_CALL) withObject:nil afterDelay:0.01];
    _TBL_list.hidden = YES;
    
    [_TBL_list setDragDelegate:self refreshDatePermanentKey:@"FriendList"];
    _TBL_list.showLoadMoreView = YES;


}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
       return ARR_total_data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    news_cell *cell = (news_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"news_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    @try
    {
          NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"]];
        NSString *str_image = [NSString stringWithFormat:@"%@%@",str_image_base_URl,[[ARR_total_data objectAtIndex:indexPath.section] valueForKey:@"image"]];
        
        [cell.IMG_title sd_setImageWithURL:[NSURL URLWithString:str_image]
                             placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        
    NSString *str_title = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_total_data objectAtIndex:indexPath.section]valueForKey:@"title"]]];
    cell.LBL_name.text = str_title;
   
    
    NSString *str_time = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_total_data objectAtIndex:indexPath.section] valueForKey:@"created"]]];
    
    NSString *description =[NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_total_data objectAtIndex:indexPath.section] valueForKey:@"content"]]];
    description = [description stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: 'FuturaT-Medi'; font-size:%dpx;}</style>",15]];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[description dataUsingEncoding:NSUTF8StringEncoding]options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),NSForegroundColorAttributeName:[UIColor grayColor]}documentAttributes:nil error:nil];
    cell.LBL_address.attributedText = attributedString;
    NSString *str = cell.LBL_address.text;
    str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
    cell.LBL_address.text = str;
    cell.LBL_company.text = str_time;
    
    }
    @catch(NSException *exception)
    {
        NSLog(@"The Exception from News list:%@",exception);
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
      NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"]];
    
    NSString *str_URL = [NSString stringWithFormat:@"%@%@",str_image_base_URl,[[[jsonresponse_DIC valueForKey:@"newsList"] objectAtIndex:indexPath.section] valueForKey:@"url_key"]];
    str_URL = [str_URL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];
    
    [[NSUserDefaults standardUserDefaults]  setValue:@"ARTICLES" forKey:@"header_val"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.delegate static_page_view_call];

    
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


#pragma News API call

-(void)News_API_CALL
{
    
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
          NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
        NSString *URL_ST = [NSString stringWithFormat:@"%@newsList/%@/1",str_image_base_URl,@"0"];
        URL_ST = [URL_ST stringByReplacingOccurrencesOfString:@"" withString:@"%20"];

        URL_ST = [URL_ST stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSURL *urlProducts=[NSURL URLWithString:URL_ST];
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
             [self.delegate hide_over_lay];
            if([[jsonresponse_DIC valueForKey:@"newsList"] count]>=1)
            {
                
            NSLog(@"%@",jsonresponse_DIC);
             _TBL_list.hidden = NO;
            ARR_total_data = [jsonresponse_DIC valueForKey:@"newsList"];
            [_TBL_list reloadData];
            }
            else{
                   _TBL_list.hidden = YES;
                
                [APIHelper createaAlertWithMsg:@"No Articles found," andTitle:nil];
              
            }
            
            
        }
        else
        {
            NSDictionary *dictin = [[NSDictionary alloc]initWithObjectsAndKeys:@"Nodata",@"error", nil];
            NSLog(@"%@",dictin);
             _TBL_list.hidden = YES;
        }
    }
    @catch(NSException *Exception)
    {
        
    }
    
}


-(void)Search_API_called
{
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *URL_ST = [NSString stringWithFormat:@"%@newsList/%@/1",SERVER_URL,_TXT_search.text];
        URL_ST = [URL_ST stringByReplacingOccurrencesOfString:@"" withString:@"%20"];

        URL_ST = [URL_ST stringByReplacingOccurrencesOfString:@" " withString:@"%20"];

        
        NSURL *urlProducts=[NSURL URLWithString:URL_ST];
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
            if([[jsonresponse_DIC valueForKey:@"newsList"] count]>=1)
            {
                NSLog(@"%@",jsonresponse_DIC);
                _TBL_list.hidden = NO;
                [ARR_total_data removeAllObjects];
                [ARR_total_data addObjectsFromArray: [jsonresponse_DIC valueForKey:@"newsList"]];
                [_TBL_list reloadData];
            }
            else{
                _TBL_list.hidden = YES;
                
                [APIHelper createaAlertWithMsg:@"No Articles found," andTitle:nil];
                
            }
            
            
        }
        else
        {
            NSDictionary *dictin = [[NSDictionary alloc]initWithObjectsAndKeys:@"Nodata",@"error", nil];
            NSLog(@"%@",dictin);
            _TBL_list.hidden = YES;
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
        NSString *int_VAL = [NSString stringWithFormat:@"%@",[jsonresponse_DIC valueForKey:@"totalNoOfNews"]];
        NSLog(@"The products Count:%lu",(unsigned long)[ARR_total_data count]);
        
        if([int_VAL intValue] == [ARR_total_data count])
        {
            [APIHelper stop_activity_animation:self];
            
            [self performSelector:@selector(finishLoadMore) withObject:nil afterDelay:0.01];
            
        }
        else
        {
            
            page_count =  page_count  + 1;
          
            
            NSString *url_STR = URL_STR;
            url_STR = [NSString stringWithFormat:@"%@newsList/%@/%d",SERVER_URL,@"0",page_count];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Sorry no more Articles found." delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                [alert show];
            }
            else{
                
                @try
                {
                    if([[dict valueForKey:@"newsList"] count] >= 1)
                    {
                        NSMutableArray *new_ARR = [[NSMutableArray alloc]init];
                        new_ARR = [dict valueForKey:@"List"];
                        [ARR_total_data addObjectsFromArray:new_ARR];
                        [_TBL_list reloadData];
                        
                    }
                    else{
                        [APIHelper createaAlertWithMsg:@"No more Articles found" andTitle:@""];
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

#pragma count API
-(void)CountAvailableNotification_API
{
    NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
    NSString *str_URL = [NSString stringWithFormat:@"%@notificationCount",str_image_base_URl];
    @try
    {
        NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
        
        
        NSDictionary *parameters = @{@"customer_id":str_member_ID};
        [APIHelper postServiceCall:str_URL andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
            }
            if(data)
            {
                NSString *str_code = [NSString stringWithFormat:@"%@",[data valueForKey:@"code"]];
                if([str_code isEqualToString:@"1"])
                {
                    
                    NSDictionary *TEMP_dict = data;
                    NSLog(@"The login customer Data:%@",TEMP_dict);
                    
                    NSString *str_count = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"favCount"]];
                    
                    dispatch_async(dispatch_get_main_queue(),
                                   ^{
                                       [self.BTN_favourite setTitle:[APIHelper set_count:str_count] forState:UIControlStateNormal];
                                       
                                   });
                    
                }
                else
                {
                    [APIHelper stop_activity_animation:self];
                    [APIHelper createaAlertWithMsg:@"Some thing went wrong" andTitle:@"Alert"];
                    
                }
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        [APIHelper createaAlertWithMsg:@"Some thing went wrong" andTitle:@"Alert"];
        
    }
    
    //  [notification removeObserver:self forKeyPath:@"NEW_NOTIFICATIO_COUNT"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self removeFromParentViewController];
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
