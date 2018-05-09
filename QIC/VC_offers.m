//
//  VC_offers.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_offers.h"
#import "offers_list_cell.h"
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface VC_offers ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    NSMutableArray *arr_images;
    NSDictionary *jsonresponse_DIC;
    
    
}


@end

@implementation VC_offers

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arr_images = [[NSMutableArray alloc]init];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];

    [APIHelper start_animation:self];
    [self performSelector:@selector(Offers_API_CALL) withObject:nil afterDelay:0.01];


}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if([[jsonresponse_DIC valueForKey:@"Services"] isKindOfClass:[NSArray class]])
    {
        count = [[jsonresponse_DIC valueForKey:@"Services"] count];
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
    offers_list_cell *cell = (offers_list_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"offers_list_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    @try
    {
    NSString *str_image = [NSString stringWithFormat:@"%@%@",IMAGE_URL,[[[jsonresponse_DIC valueForKey:@"Services"]objectAtIndex:indexPath.section] valueForKey:@"image"]];
    str_image = [APIHelper convert_NUll:str_image];
        
        str_image = [str_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    
    [cell.IMG_image sd_setImageWithURL:[NSURL URLWithString:str_image]
                      placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"Services"] objectAtIndex:indexPath.section] valueForKey:@"description"]]];
        
    str_name = [str_name uppercaseString];
    
    cell.LBL_name.text =str_name;
    }
    @catch(NSException *exception)
    {
        
    }
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate consultation_offers:@"consulation"];
    [[NSUserDefaults standardUserDefaults]  setValue:[[[jsonresponse_DIC valueForKey:@"Services"] objectAtIndex:indexPath.section] valueForKey:@"id"] forKey:@"service_ID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma Textfield Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];

    _LBL_search_place_holder.alpha = 0.0f;
    [self.delegate offers_search_page_calling];
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
#pragma News API call

-(void)Offers_API_CALL
{
    
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *URL_STR = [NSString stringWithFormat:@"%@getServicesList",SERVER_URL];
        
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
             [self.delegate hide_over_lay];
            jsonresponse_DIC =(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            NSLog(@"%@",jsonresponse_DIC);
            [_TBL_list reloadData];
            
            
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
