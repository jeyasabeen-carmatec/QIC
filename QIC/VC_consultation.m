//
//  VC_consultation.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_consultation.h"
#import "consultation_cell.h"

@interface VC_consultation ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray  *arr_status;
    
}

@end

@implementation VC_consultation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_status  = [[NSMutableArray alloc]init];
    for(int i= 0 ;i<= 10;i++)
    {
        [arr_status addObject:@"active"];
    }
    
    [_BTN_bcak addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];


}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10
    ;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    consultation_cell *cell = (consultation_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"consultation_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.LBL_name.text = @"Al SHAMI MEDICAL CENTER";
    cell.LBL_addres.text = @"Wadi Al utooria Street,\nAin Khaled.";

    cell.LBL_designnantion.text = @"Services: Consultation";
    
    cell.VW_back_ground.layer.cornerRadius = 2.0f;
    //cell.IMG_title.layer.cornerRadius = cell.IMG_title.frame.size.width/2;
    cell.IMG_title.layer.masksToBounds = YES;
    cell.LBL_cost.layer.cornerRadius = 3.0f;
    cell.LBL_cost.layer.borderWidth = 1.0f;
    cell.LBL_cost.layer.borderColor = cell.LBL_name.textColor.CGColor;
    
    [cell.BTN_favourite addTarget:self action:@selector(wish_list_action:) forControlEvents:UIControlEventTouchUpInside];
    cell.BTN_favourite.tag = indexPath.section;
    
    cell.BTN_favourite.titleLabel.textColor = [UIColor colorWithRed:0.33 green:0.72 blue:0.78 alpha:1.0];
    
    
    
    if([[arr_status objectAtIndex:indexPath.section] isEqualToString:@"inactive"])
    {
        [cell.BTN_favourite setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        [cell.BTN_favourite setTitle:@"" forState:UIControlStateNormal];
        
    }

  //  cell.VW_back_ground.backgroundColor = [UIColor whiteColor];
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
    [self.delegate consultation_detail:@"consultation_detail"];
}


#pragma back action
-(void)back_actions
{
    
    [self.delegate consultation_offers_back:@"back"];
}
#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
#pragma Wish_list_action
-(void)wish_list_action:(UIButton *)sender
{
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:sender.tag];
    consultation_cell *cell = (consultation_cell *)[self.TBL_list cellForRowAtIndexPath:index];
    
    if([cell.BTN_favourite.titleLabel.text isEqualToString:@""])
    {
         [arr_status removeObjectAtIndex:sender.tag];
         [arr_status insertObject:@"inactive" atIndex:sender.tag];
        
       [cell.BTN_favourite setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        [arr_status removeObjectAtIndex:sender.tag];
        [arr_status insertObject:@"active" atIndex:sender.tag];
        [cell.BTN_favourite setTitle:@"" forState:UIControlStateNormal];

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
