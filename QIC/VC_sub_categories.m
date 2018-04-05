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

@interface VC_sub_categories ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_images;
}


@end

@implementation VC_sub_categories

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arr_images = [NSArray arrayWithObjects:@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg", nil];
    [_BTN_bcak addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
}
#pragma Table view delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return arr_images.count;
    
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
    
    cell.LBL_name.text = @"Al SHAMI MEDICAL CENTER";
    cell.LBL_addres.text = @"This is going to Provide some offers. which is useful to do the insurance.You will get that in  an Exact time.";
    cell.LBL_designnantion.text = @"Dentist";
    cell.LBL_phone.text = @"PH:123456789";
    cell.VW_background.layer.cornerRadius = 2.0f;
    
    cell.IMG_title.layer.cornerRadius = cell.IMG_title.frame.size.width/2;
    
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
    [self.delegate detail_page_visibility:@"subcategory_detail"];
}

#pragma back action
-(void)back_actions
{
    [self.delegate subcategories_back_action:@"back"];
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
