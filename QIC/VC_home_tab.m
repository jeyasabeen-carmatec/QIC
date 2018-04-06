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
{
    NSArray *arr_images;
}
@end

@implementation VC_home_tab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _TBL_list.delegate= self;
//    _TBL_list.dataSource = self;
    
    arr_images = [NSArray arrayWithObjects:@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg",@"Banner-A.jpg",@"Banner-B.jpg",@"Banner-C.jpg", nil];
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
    menu_cell *cell = (menu_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"menu_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    UIImage *img = [UIImage imageNamed:[arr_images objectAtIndex:indexPath.row]];
    cell.IMG_image.image = img;
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
#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
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
