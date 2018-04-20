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



@interface VC_news ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *arr_images;
    NSDictionary *jsonresponse_DIC;
}


@end

@implementation VC_news

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_images = [NSArray arrayWithObjects:@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg",@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg", nil];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    
    [APIHelper start_animation:self];
    [self performSelector:@selector(News_API_CALL) withObject:nil afterDelay:0.01];

}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger count = 0;
    if([[jsonresponse_DIC valueForKey:@"newsList"] isKindOfClass:[NSArray class]])
    {
        count = [[jsonresponse_DIC valueForKey:@"newsList"] count];
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
    news_cell *cell = (news_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"news_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    @try
    {
        
        NSString *str_image = [NSString stringWithFormat:@"%@%@",SERVER_URL,[[[jsonresponse_DIC valueForKey:@"newsList"]objectAtIndex:indexPath.section] valueForKey:@"image"]];
        
        [cell.IMG_title sd_setImageWithURL:[NSURL URLWithString:str_image]
                             placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];

        
    NSString *str_title = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"newsList"]objectAtIndex:indexPath.section]valueForKey:@"title"]]];
    cell.LBL_name.text = str_title;
   
    
    NSString *str_time = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"newsList"]objectAtIndex:indexPath.section] valueForKey:@"created"]]];
    
    NSString *description =[NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[[jsonresponse_DIC valueForKey:@"newsList"]objectAtIndex:indexPath.section] valueForKey:@"content"]]];
    description = [description stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: 'FuturaT-Medi'; font-size:%dpx;}</style>",17]];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[description dataUsingEncoding:NSUTF8StringEncoding]options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}documentAttributes:nil error:nil];
    cell.LBL_address.attributedText = attributedString;
    NSString *str = cell.LBL_address.text;
    str = [str stringByReplacingOccurrencesOfString:@"/" withString:@"\n"];
    cell.LBL_address.text = str;
    cell.LBL_company.text = str_time;
   // cell.IMG_title.image = [UIImage imageNamed:[arr_images objectAtIndex:indexPath.section]];
    
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
    NSString *str_URL = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"newsList"] objectAtIndex:indexPath.row] valueForKey:@"url_key"]];
    [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];
    
    [[NSUserDefaults standardUserDefaults]  setValue:@"NEWS" forKey:@"header_val"];
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

#pragma News API call

-(void)News_API_CALL
{
    
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *URL_STR = [NSString stringWithFormat:@"%@newsList",SERVER_URL];
        
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
