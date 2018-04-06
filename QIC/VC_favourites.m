//
//  VC_providers.m
//  QIC
//
//  Created by anumolu mac mini on 06/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_favourites.h"
#import"favourites_cell.h"



@interface VC_favourites ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arr_images;
}

@end

@implementation VC_favourites

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
    favourites_cell *cell = (favourites_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"favourites_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.LBL_name.text = @"Al SHAMI MEDICAL CENTER";
    cell.LBL_addres.text = @"This is going to Provide some offers. which is useful to do the insurance.You will get that in  an Exact time.";
    cell.LBL_designnantion.text = @"Services: Dentist";
    
    cell.VW_back_ground.layer.cornerRadius = 2.0f;
    //  cell.VW_back_ground.backgroundColor = [UIColor whiteColor];
    
    cell.IMG_title.layer.cornerRadius = cell.IMG_title.frame.size.width/2;
    cell.IMG_title.layer.masksToBounds = YES;

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
   // [self.delegate consultation_detail:@"consultation_detail"];
}
#pragma Back action
-(void)back_actions
{
    [self.delegate favourites_back_ACTION];
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
