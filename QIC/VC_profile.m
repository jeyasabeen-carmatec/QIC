//
//  VC_profile.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_profile.h"
#import "profile_cell.h"
#import "Profile_langugage_cell.h"
#import "APIHelper.h"
@interface VC_profile ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    CGRect frameset;
    NSArray *ARR_icons;
    NSArray *DICT_profile;
    NSDictionary *TEMP_dict;
    UIPickerView *Lang_picker;
    
}

@end

@implementation VC_profile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    ARR_icons = [NSArray arrayWithObjects:@"profile-icon.png",@"fingerprint.png",@"Vector-Smart-Object.png",@"validity.png",@"dependent.png",@"Vector-Smart-Object.png",@"change-language.png",@"About-QIC.png",@"privacy-policy.png",@"terms-&-condition.png", nil];
    
    ARR_icons = [NSArray arrayWithObjects:@"profile-icon.png",@"fingerprint.png",@"Vector-Smart-Object.png",@"validity.png",@"dependent.png",@"Vector-Smart-Object.png",@"terms-&-condition.png", nil];
    

   
    
    [self set_UP_DATA];
    
    [self set_UP_VIEW];
    
}
#pragma set up DATA

-(void)set_UP_DATA
{
    @try
    {
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];

    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"memberName"]]];
     NSString *str_QID = [NSString stringWithFormat:@"QID : %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"membershipNo"]]];
    NSString *str_MID = [NSString stringWithFormat:@"Membership ID : %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"membershipNo"]]];
        
   NSString *str_fromdate = [NSString stringWithFormat:@"%@",[self getting_from_date:[[TEMP_dict valueForKey:@"validityFromDate"] doubleValue]]];
    
   NSString * str_to_date = [NSString stringWithFormat:@"%@",[self getting_from_date:[[TEMP_dict valueForKey:@"validityToDate"] doubleValue]]];
    
    NSString *str_validity = [NSString stringWithFormat:@"Validity : %@ to %@",str_fromdate,str_to_date];
//        DICT_profile = [NSArray arrayWithObjects:str_name,str_QID,str_MID,str_validity,@"Depenedents",@"Health Card",@"Change language",@"About QIC",@"Privacy Policy",@"Terms and Conditions", nil];

    
    DICT_profile = [NSArray arrayWithObjects:str_name,str_QID,str_MID,str_validity,@"Depenedents",@"Health Card",@"Terms and Conditions", nil];
    }
    @catch(NSException *exception)
    {
        NSLog(@"The exception from setting the data:%@",exception);
    }
    }
#pragma set up view 

-(void)set_UP_VIEW
{
    
    
    _LBL_profile_name.numberOfLines = 0;
    [_LBL_profile_name sizeToFit];
    
    @try
    {
    _LBL_profile_name.text =[NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"memberName"]]];

    _LBL_mobile_number.text =[NSString stringWithFormat:@"  %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"mobileNo"]]];
    }
    @catch(NSException *exception)
    {
        NSLog(@"Exception from User_name,phone_number");
    }
    
    
    [_LBL_mobile_number sizeToFit];
     _LBL_mobile_number.numberOfLines = 0;
    

    frameset = _LBL_mobile_number.frame;
    frameset.origin.y = _LBL_profile_name.frame.origin.y + _LBL_profile_name.frame.size.height + 4;
    _LBL_mobile_number.frame = frameset;
    
    frameset = _TBL_profile.frame;
    frameset.origin.y = _LBL_mobile_number.frame.origin.y + _LBL_mobile_number.frame.size.height + 20;
    _TBL_profile.frame = frameset;
    
    
    
    frameset =_VW_main.frame;
    frameset.size.height = _Scroll_contents.frame.size.height - 50;
    frameset.size.width = _Scroll_contents.frame.size.width;
    _VW_main.frame =  frameset;
    [_Scroll_contents addSubview:_VW_main];
    
    _VW_IMG_background.layer.cornerRadius = _VW_IMG_background.frame.size.width/2;
    _IMG_prfoile_image.layer.cornerRadius = _IMG_prfoile_image.frame.size.width/2;
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     [_Scroll_contents layoutIfNeeded];
    
    _Scroll_contents.contentSize= CGSizeMake(_Scroll_contents.frame.size.width, _TBL_profile.frame.origin.y +  _TBL_profile.contentSize.height);
    
    
}
#pragma Tableview delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ARR_icons.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    profile_cell *cell = (profile_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"profile_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    


    
    cell.IMG_icon.image = [UIImage imageNamed:[ARR_icons objectAtIndex:indexPath.row]];
    cell.LBL_name.text  = [DICT_profile objectAtIndex:indexPath.row];
    cell.BTN_arrow.hidden = YES;
    
    if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"] || [[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Change language"])
    {
         cell.BTN_arrow.hidden = NO;
    }
    
    
    if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Change language"])
    {
        Profile_langugage_cell *cell = (Profile_langugage_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];

        
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"profile_cell" owner:self options:nil];
        cell = [nib objectAtIndex:1];
       
        
        Lang_picker = [[UIPickerView alloc] init];
        Lang_picker.delegate = self;
        Lang_picker.dataSource = self;
        UIToolbar* conutry_close = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        conutry_close.barStyle = UIBarStyleBlackTranslucent;
        [conutry_close sizeToFit];
        
        UIButton *close=[[UIButton alloc]init];
        close.frame=CGRectMake(conutry_close.frame.origin.x -20, 0, 100, conutry_close.frame.size.height);
        [close setTitle:@"Close" forState:UIControlStateNormal];
        [close addTarget:self action:@selector(close_action) forControlEvents:UIControlEventTouchUpInside];
        [conutry_close addSubview:close];
        
     
        
        UIButton *done=[[UIButton alloc]init];
        done.frame=CGRectMake(conutry_close.frame.size.width - 100, 0, 100, conutry_close.frame.size.height);
        [done setTitle:@"Done" forState:UIControlStateNormal];
        [done addTarget:self action:@selector(done_action) forControlEvents:UIControlEventTouchUpInside];
        [conutry_close addSubview:done];
        
        done.tag = indexPath.row;
        
        cell.LBL_name.inputAccessoryView=conutry_close;
        cell.LBL_name.inputView = Lang_picker;
        cell.LBL_name.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"language-name"];
        cell.LBL_name.tintColor=[UIColor clearColor];

        
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
    if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"])
    {
        if([[TEMP_dict valueForKey:@"mebList"] isKindOfClass:[NSArray class]] || TEMP_dict.count > 1 )
        {
            [self.delegate dependets_ACTION:@"profile"];
        }
        else{
            [APIHelper createaAlertWithMsg:@"No Dependents Found" andTitle:@""];
        }
    }
   else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Health Card"])
    {
        [self.delegate health_card_ACTION];
    }
   else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Privacy Policy"])
   {
       
       NSString *str_URL = [NSString stringWithFormat:@"%@pages/privacyPolicy",STATCI_URL];
       [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];

       [[NSUserDefaults standardUserDefaults] setValue:@"PRIVACY POLICY" forKey:@"header_val"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       
       
       
       [self.delegate static_page_view_call];
   }
    else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Terms and Conditions"])
    {
        NSString *str_URL = [NSString stringWithFormat:@"%@pages/termsAndConditions",STATCI_URL];
        [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];

        [[NSUserDefaults standardUserDefaults] setValue:@"TERMS AND CONDITIONS" forKey:@"header_val"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         [self.delegate static_page_view_call];

        
    }


    

}


#pragma mark - UIPickerViewDataSource Delegate Methods


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    
    return 1;
}

#pragma mark - UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
        
        return @"Englsih";
    
   }


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
}
#pragma Picker Button actions
-(void)close_action
{
    [_TBL_profile reloadData];
}
-(void)done_action
{
    [_TBL_profile reloadData];

}

#pragma Converting the Time stamps

-(NSString*)getting_from_date:(double )timeStamp{
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
