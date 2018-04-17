//
//  VC_offers.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_offers.h"
#import "offers_list_cell.h"

@interface VC_offers ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

{
    NSMutableArray *arr_images;
}


@end

@implementation VC_offers

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    arr_images = [[NSMutableArray alloc]init];
  
    
    NSDictionary *temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"CONSULTATIONS",@"key1",@"Banner-A.jpg",@"key2",nil];
    [arr_images addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"INVESTIGATIONS/LAB/RADIOLOGY",@"key1",@"Banner-B.jpg",@"key2", nil];
    [arr_images addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"PROCEDURES",@"key1",@"Banner-C.jpg",@"key2", nil];
    [arr_images addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"CONSULTATIONS",@"key1",@"Banner-A.jpg",@"key2", nil];
    [arr_images addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"PROCEDURES",@"key1",@"Banner-B.jpg",@"key2", nil];
    [arr_images addObject:temp_dict];
    

    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];

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
    offers_list_cell *cell = (offers_list_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"offers_list_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIImage *img = [UIImage imageNamed:[[arr_images objectAtIndex:indexPath.section] valueForKey:@"key2"]];
    cell.IMG_image.image = img;
    cell.LBL_name.text = [[arr_images objectAtIndex:indexPath.section] valueForKey:@"key1"];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 170;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate consultation_offers:@"consulation"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
