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
    cell.LBL_addres.text = @"Wadi Al utooria Street,\nAin Khaled.";
    cell.LBL_designnantion.text = @"Services: Dentist";
   NSString *discount = @"10%";

    
    NSString *str_addres = [NSString  stringWithFormat:@"%@\ndiscount",discount];
    
    if ([cell.LBL_price_amount respondsToSelector:@selector(setAttributedText:)])
    {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:cell.LBL_price_amount.textColor,
                                  NSFontAttributeName: cell.LBL_price_amount.font,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_addres attributes:attribs];
        
        CGSize result = [[UIScreen mainScreen] bounds].size;
        float size;
        if(result.height <= 480)
        {
            size = 13.0;
        }
        else if(result.height <= 568)
        {
            size = 15.0;
        }
        else
        {
            size = 17.0;
        }
        
        cell.LBL_price_amount.font = [UIFont fontWithName:@"Futura-Heavy" size:size];
        @try
        {

        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Heavy" size:size],NSForegroundColorAttributeName:[UIColor colorWithRed:0.33 green:0.72 blue:0.78 alpha:1.0],}range:[str_addres rangeOfString:discount] ];
        }
        @catch(NSException *exception)
        {
            NSLog(@"Exception for attributed text:%@",exception);
        }
        
        cell.LBL_price_amount.attributedText = attributedText;
    }
    else{
        cell.LBL_price_amount.text = str_addres;
    }
    
    cell.LBL_price_amount.transform=CGAffineTransformMakeRotation( ( 90 * M_PI ) / -360 );

    cell.VW_back_ground.layer.cornerRadius = 2.0f;
   
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
}
#pragma Back action
-(void)back_actions
{
    NSString *str_page = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];
    [self.delegate favourites_back_ACTION:str_page];
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
