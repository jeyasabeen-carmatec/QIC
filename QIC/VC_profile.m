//
//  VC_profile.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_profile.h"
#import "profile_cell.h"

@interface VC_profile ()<UITableViewDelegate,UITableViewDataSource>
{
    CGRect frameset;
    NSArray *ARR_icons;
    NSArray *ARR_profile;
    
}

@end

@implementation VC_profile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ARR_icons = [NSArray arrayWithObjects:@"profile-icon.png",@"Vector-Smart-Object.png",@"Vector-Smart-Object.png",@"validity.png",@"dependent.png",@"change-language.png",@"About-QIC.png",@"privacy-policy.png",@"terms-&-condition.png", nil];
    ARR_profile = [NSArray arrayWithObjects:@"Arbella massified",@"QID : 123456789",@"Membership ID : 123456789",@"Validity : 22/01/2017 to  22/01/2019",@"Depenedents",@"Change language",@"About QIC",@"Privacy Policy",@"Terms and Conditions", nil];
    
    [self set_UP_VIEW];
}
#pragma set up view 

-(void)set_UP_VIEW
{
    
    frameset = _LBL_profile_name.frame;
    frameset.size.width = _Scroll_contents.frame.size.width;
    _LBL_profile_name.frame = frameset;
    
    _LBL_profile_name.numberOfLines = 0;
    [_LBL_profile_name sizeToFit];
    
    _LBL_mobile_number.text = @" 123456789";
    
    [_LBL_mobile_number sizeToFit];
     _LBL_mobile_number.numberOfLines = 0;
    

    frameset = _LBL_mobile_number.frame;
    frameset.size.width = _Scroll_contents.frame.size.width;
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
    return ARR_profile.count;
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
    cell.LBL_name.text  = [ARR_profile objectAtIndex:indexPath.row];
     cell.BTN_arrow.hidden = YES;
    
    if([[ARR_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"] || [[ARR_profile objectAtIndex:indexPath.row] isEqualToString:@"Change language"])
    {
        cell.BTN_arrow.hidden = NO;
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
    if([[ARR_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"] || [[ARR_profile objectAtIndex:indexPath.row] isEqualToString:@"Change language"])
    {
        [self.delegate dependets_ACTION:@"profile"];
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
