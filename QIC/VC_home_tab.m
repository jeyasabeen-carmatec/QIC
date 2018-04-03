//
//  VC_home_tab.m
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_home_tab.h"
#import "menu_cell.h"

@interface VC_home_tab ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation VC_home_tab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _TBL_list.delegate= self;
    _TBL_list.dataSource = self;
}
#pragma Table view delegate Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    menu_cell *cell = (menu_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"menu_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
