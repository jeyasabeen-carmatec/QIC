//
//  VC_home.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_home.h"
#import "VC_categories.h"
#import "VC_home_tab.h"

@interface VC_home ()<UITabBarDelegate>

@end

@implementation VC_home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /********************* setting the delegates ***************************/
 
    
    [self highlight_IMAGE];
    [self tab_BAR_set_UP];
}
#pragma mark highight the Tab menu indicator image

-(void)highlight_IMAGE
{
    /*************************** Setting the selector image for tab image  ***************************/
    
    CGFloat highlightedWidth = self.view.frame.size.width/_TAB_menu.items.count;
    [_TAB_menu setItemWidth:highlightedWidth];
    CGRect rect = CGRectMake(0, 9, highlightedWidth, _TAB_menu.frame.size.height+21);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.11 green:0.40 blue:0.40 alpha:1.0] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _TAB_menu.selectionIndicatorImage = img;

}
#pragma tab bar setUP

-(void)tab_BAR_set_UP
{
    
    CGRect frameset = _TAB_menu.frame;
      frameset.size.height = 50;
    _TAB_menu.frame = frameset;
    
    _TAB_menu.delegate = self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:11.0f],NSForegroundColorAttributeName:[UIColor whiteColor]
                                                        } forState:UIControlStateNormal];
    
}
#pragma Tab bar did select Item

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item

{
    if([item.title isEqualToString:@"Home"])
    {
      //  [self.view addSubview:self.TBL_list];
        
        VC_home_tab *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_home_tab"];
        CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = self.view.frame.size.height - _TAB_menu.frame.size.height;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
        [self.VW_main addSubview:categorie_vw.view];

    }
    
    else  if([item.title isEqualToString:@"Provider"])
    {
        
        VC_categories *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_categoies"];
        CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = self.view.frame.size.height - _TAB_menu.frame.size.height;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
        [self.VW_main addSubview:categorie_vw.view];
        
        
        
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
