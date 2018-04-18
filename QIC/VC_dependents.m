//
//  VC_dependents.m
//  QIC
//
//  Created by anumolu mac mini on 05/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_dependents.h"
#import "dependents_cell.h"
#import "APIHelper.h"

@interface VC_dependents ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *ARR_dependents;
    NSDictionary *TEMP_dict;
}

@end

@implementation VC_dependents

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
    
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
    
    ARR_dependents = [TEMP_dict valueForKey:@"mebList"];
 
    
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];

}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ARR_dependents.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    dependents_cell *cell = (dependents_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"dependents_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *string_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"memberName"]]];
    
    NSString *string_relation = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"relationDesc"]]];
    if([string_relation isEqualToString:@"SELF"])
    {
        string_relation = @"PRIMARY";
    }
    NSString *str_QID = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"membershipNo"]]];
    
    NSString *str_MID = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"membershipNo"]]];
    
    NSString *str_fromdate = [NSString stringWithFormat:@"%@",[self getting_from_date:[[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"validityFromDate"] doubleValue]]];
    NSString * str_to_date = [NSString stringWithFormat:@"%@",[self getting_from_date:[[[ARR_dependents objectAtIndex:indexPath.section] valueForKey:@"validityToDate"] doubleValue]]];
    
    NSString *str_validity = [NSString stringWithFormat:@"Validity : %@ to %@",str_fromdate,str_to_date];

    cell.LBL_dependent_name.text = string_name;
    cell.LBL_relation.text = string_relation;
    
    NSString  *str_qid;
    
    if ([cell.LBL_QID respondsToSelector:@selector(setAttributedText:)])
    {
    
    str_qid = [NSString stringWithFormat:@"Qatar ID Number: %@",str_QID];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_qid attributes:nil];
    
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FuturaT-Medi" size:15.0],NSForegroundColorAttributeName:[UIColor blackColor],}range:[str_qid rangeOfString:str_QID] ];
    
    
    cell.LBL_QID.attributedText = attributedText;
    }
    else{
        cell.LBL_QID.text = str_qid;
    }
    NSString  *member_ID;
    
    if ([cell.LBL_member_ID respondsToSelector:@selector(setAttributedText:)])
    {
        
            member_ID = [NSString stringWithFormat:@"Membership ID: %@",str_MID];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:member_ID attributes:nil];
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"FuturaT-Medi" size:15.0],NSForegroundColorAttributeName:[UIColor blackColor],}range:[member_ID rangeOfString:str_MID] ];
        
        
        cell.LBL_member_ID.attributedText = attributedText;
    }
    else{
        cell.LBL_member_ID.text = member_ID;
    }
    cell.LBL_validity.text = str_validity;
    
    
    cell.VW_back_ground.layer.cornerRadius = 2.0f;

    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 10;
//}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [self.delegate consultation_offers:@"consulation"];
    
}

#pragma Back Action
-(void)back_action
{
    [self.delegate back_ACTION:@"back"];
}
#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
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
