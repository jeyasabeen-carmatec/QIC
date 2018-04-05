//
//  VC_dependents.m
//  QIC
//
//  Created by anumolu mac mini on 05/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_dependents.h"
#import "dependents_cell.h"

@interface VC_dependents ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_images;
}

@end

@implementation VC_dependents

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_BTN_back addTarget:self action:@selector(back_action) forControlEvents:UIControlEventTouchUpInside];
}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
    
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
    cell.LBL_dependent_name.text = @"MICHAEl ROGGER";
    cell.LBL_relation.text = @"Parent";
    NSString  *str_qid;
    
    if ([cell.LBL_QID respondsToSelector:@selector(setAttributedText:)])
    {
    
    NSString *str_QID = @"1234567891";
    str_qid = [NSString stringWithFormat:@"Qatar ID Number: %@",str_QID];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_qid attributes:nil];
    
    [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15.0],NSForegroundColorAttributeName:[UIColor blackColor],}range:[str_qid rangeOfString:str_QID] ];
    
    
    cell.LBL_QID.attributedText = attributedText;
    }
    else{
        cell.LBL_QID.text = str_qid;
    }
    NSString  *member_ID;
    
    if ([cell.LBL_member_ID respondsToSelector:@selector(setAttributedText:)])
    {
        
        NSString *str_MID = @"1234567891";
        member_ID = [NSString stringWithFormat:@"Membership ID: %@",str_MID];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:member_ID attributes:nil];
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15.0],NSForegroundColorAttributeName:[UIColor blackColor],}range:[member_ID rangeOfString:str_MID] ];
        
        
        cell.LBL_member_ID.attributedText = attributedText;
    }
    else{
        cell.LBL_member_ID.text = member_ID;
    }
    cell.LBL_validity.text = @"Valid from 01/04/2018 to 01/04/2019";
    
    
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
    [self.delegate consultation_offers:@"consulation"];
    
}

#pragma Back Action
-(void)back_action
{
    [self.delegate back_ACTION:@"back"];
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
