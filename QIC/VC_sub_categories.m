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

@interface VC_sub_categories ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSMutableArray *arr_total_data;
}


@end

@implementation VC_sub_categories

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_total_data = [[NSMutableArray alloc]init];

    NSDictionary *temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-A.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
  temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-B.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
  temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-C.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
   temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-A.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
   temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-B.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-C.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-A.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-B.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Al SHAMI MEDICAL CENTER",@"key1",@"Dentist",@"key2",@"Wadi Al utooria Street,\nAin Khaled.",@"key3",@"PH:123456789",@"key4",@"Banner-A.jpg",@"key5",nil];
    [arr_total_data addObject:temp_dict];

   
    [_BTN_bcak addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];

}
#pragma Table view delegate Methods

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
    subcategory_cell *cell = (subcategory_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"subcategory_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.contentView.layer.cornerRadius = 2.0f;
    
    cell.LBL_name.text = [[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"key1"];
    cell.LBL_addres.text =[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"key3"];
    cell.LBL_designnantion.text = [[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"key2"];
    cell.LBL_phone.text = [[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"key4"];
    cell.VW_background.layer.cornerRadius = 2.0f;
    
    cell.IMG_title.layer.cornerRadius = cell.IMG_title.frame.size.width/2;
    cell.IMG_title.layer.masksToBounds = YES;
    
    cell.IMG_title.image = [UIImage imageNamed:[[arr_total_data objectAtIndex:indexPath.section] valueForKey:@"key5"]];
    cell.BTN_phone.tag =  indexPath.section;
    [cell.BTN_phone addTarget:self action:@selector(mobile_dial:) forControlEvents:UIControlEventTouchUpInside];
    
    

    
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
}

#pragma back action
-(void)back_actions
{
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

#pragma mark Mobile _call

-(void)mobile_dial:(UIButton *)sender
{
    NSIndexPath *buttonIndexPath1 = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    NSLog(@"From Delete Skill %ld",(long)buttonIndexPath1.row);
    NSString *index_str = [NSString stringWithFormat:@"%ld",(long)buttonIndexPath1.row];
    NSLog(@"Index path of Upcomming Event %@",index_str);
     NSString *phone_number;
    @try {
        phone_number = @"1234567891";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
