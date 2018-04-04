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
#import "VC_offers.h"
#import "VC_news.h"
#import "VC_profile.h"
#import "VC_sub_categories.h"
#import "VC_consultation.h"

@interface VC_home ()<UITabBarDelegate>
{
    float scroll_ht;
    
}

@end

@implementation VC_home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /********************* setting the delegates ***************************/
    scroll_ht = _VW_main.frame.size.height;
    
    [self highlight_IMAGE];
    [self tab_BAR_set_UP];
     [self HOme_view_calling];
     [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:0]];
    
    
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
        /************** calling home view  ******************/

        
        [self HOme_view_calling];

    }
    
    else  if([item.title isEqualToString:@"Providers"])
    {
        
        /************** calling providers view  ******************/

        [self providers_view_calling];
        
        
        
    }
    else  if([item.title isEqualToString:@"News"])
    {
        /************** creating objet for News view controller and and grabbing that view  ******************/
        
        VC_news *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_news"];
        
        CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = _VW_main.frame.size.height ;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
        [self.VW_main addSubview:categorie_vw.view];
        
        [self addChildViewController:categorie_vw];
        [categorie_vw didMoveToParentViewController:self];
        
        
        
    }
    else  if([item.title isEqualToString:@"Offers"])
    {
        /************** calling Offers view  ******************/

        [self offers_view_calling];
    }
    else  if([item.title isEqualToString:@"Profile"])
    {
        /************** creating objet for Profile view controller and and grabbing that view  ******************/
        
        VC_profile *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_profile"];
        [categorie_vw.TBL_profile reloadData];
        
        
        CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = _VW_main.frame.size.height+5 ;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
        [self.VW_main addSubview:categorie_vw.view];
        
        [self addChildViewController:categorie_vw];
        [categorie_vw didMoveToParentViewController:self];
        
        
        
    }


    
}

#pragma Home page view calling

-(void)HOme_view_calling
{
    
    /************** creating objet for Home view controller and and grabbing that view  ******************/

    VC_home_tab *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_home_tab"];
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [self.VW_main addSubview:categorie_vw.view];
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];
    

}

#pragma Providers view callig

-(void)providers_view_calling
{
    
    VC_categories *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_categoies"];
    categorie_vw.delegate= self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height ;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [categorie_vw.collection_categoriesl reloadData];
    [self.VW_main addSubview:categorie_vw.view];
    
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];

}

#pragma Offers view calling

-(void)offers_view_calling
{
    
    /************** creating objet for provider view controller and and grabbing that view  ******************/
    
    VC_offers *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_offers"];
    categorie_vw.delegate= self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height ;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [self.VW_main addSubview:categorie_vw.view];
    
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];

}

#pragma categories to Sub category action

-(void)sub_categories_action:(NSString *)str_status
{
    
    /************** creating objet for sub category view controller and and grabbing that view  ******************/

    VC_sub_categories *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_subcategories"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [self.VW_main addSubview:categorie_vw.view];
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];
}

-(void)subcategories_back_action:(NSString *)str_back
{
    [self providers_view_calling];
}

#pragma offers to Consultation offers

-(void)consultation_offers:(NSString *)str_status
{
    /************** creating objet for consultation  view controller and and grabbing that view  ******************/
    
    VC_consultation *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_consultation"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [self.VW_main addSubview:categorie_vw.view];
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];

    
}
-(void)consultation_offers_back:(NSString *)str_back
{
    [self offers_view_calling];
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
