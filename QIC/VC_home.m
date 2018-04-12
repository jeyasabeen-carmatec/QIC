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
#import "VC_detail.h"
#import "VC_dependents.h"
#import "VC_favourites.h"

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
        
        [[NSUserDefaults standardUserDefaults] setValue:@"home" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [self HOme_view_calling];

    }
    
    else  if([item.title isEqualToString:@"Providers"])
    {
        
        /************** calling providers view  ******************/
        
        [[NSUserDefaults standardUserDefaults] setValue:@"providers" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        [self providers_view_calling];
        
        
        
    }
    else  if([item.title isEqualToString:@"News"])
    {
        /************** calling News view  ******************/
        
        [[NSUserDefaults standardUserDefaults] setValue:@"news" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        


        [self news_VIEW_calling];
        
    }
    else  if([item.title isEqualToString:@"Offers"])
    {
        /************** calling Offers view  ******************/
        
        [[NSUserDefaults standardUserDefaults] setValue:@"offers" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        [self offers_view_calling];
    }
    else  if([item.title isEqualToString:@"Profile"])
    {
        /************** creating objet for Profile view controller and and grabbing that view  ******************/
        
        [[NSUserDefaults standardUserDefaults] setValue:@"profile" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self Profile_VIEW_celling];
        
    }


    
}

#pragma Home page view calling

-(void)HOme_view_calling
{
    
    /************** creating objet for Home view controller and and grabbing that view  ******************/

    VC_home_tab *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_home_tab"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];
    
   
    

}

#pragma Providers view callig

-(void)providers_view_calling
{
    
    VC_categories *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_categoies"];
    categorie_vw.delegate= self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [categorie_vw.collection_categoriesl reloadData];
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

   

}

#pragma Offers view calling

-(void)offers_view_calling
{
    
    /************** creating objet for provider view controller and and grabbing that view  ******************/
    
   /* for (UIViewController *contoller in self.childViewControllers) {
        if (contoller) {
            [contoller removeFromParentViewController];
        }
    }*/
    
    VC_offers *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_offers"];
    categorie_vw.delegate = self;
    
            CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = _VW_main.frame.size.height ;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
       [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];
    

    
    
   
    }
#pragma categories to Sub category action

-(void)sub_categories_action:(NSString *)str_status
{
    
    [self sub_category_view];
}
-(void)sub_category_view
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
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

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
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

    
}
/**************** consulatation back ***********************/
-(void)consultation_offers_back:(NSString *)str_back
{
    [self offers_view_calling];
}
-(void)consultation_detail:(NSString *)str_status
{
  //  [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:1]];
    [self detail_PAGE];
}



#pragma detail page visibilty
-(void)detail_page_visibility:(NSString *)str_status;
{
    [self detail_PAGE];

}
-(void)detail_page_back:(NSString *)str_back
{
    if([str_back isEqualToString:@"providers"])
    {
        [self sub_category_view];
    }
    else  if([str_back isEqualToString:@"offers"])

    {
        [self consultation_offers:@"consult"];
    }
  //  [self sub_category_view];
}

#pragma Detail page creating
-(void)detail_PAGE
{
    VC_detail *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_detail"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

}

#pragma Profile View Pages calling
-(void)Profile_VIEW_celling
{
    VC_profile *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_profile"];
    [categorie_vw.TBL_profile reloadData];
    
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];


}
-(void)dependets_ACTION:(NSString *)str_dependet
{
    VC_dependents *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_dependents"];
  //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

}
-(void)back_ACTION:(NSString *)str_dependet
{
    [self Profile_VIEW_celling];
}

#pragma News View Calling
-(void)news_VIEW_calling
{
    
    /************** creating objet for News view controller and and grabbing that view  ******************/
    
    VC_news *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_news"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height =scroll_ht ;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];
 
}
#pragma Favourites  Action
-(void)favourites_ACTION
{
    VC_favourites *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_favourites"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [UIView transitionWithView:self.VW_main
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
                    } completion:nil
     ];

    
}
-(void)favourites_back_ACTION:(NSString *)page_param
{
    if([page_param isEqualToString:@"home"])
    {
    [self HOme_view_calling];
    }
    else if([page_param isEqualToString:@"providers"])
    {
    [self providers_view_calling];
    }
    else if([page_param isEqualToString:@"news"])
    {
        [self news_VIEW_calling];
    }
    else if([page_param isEqualToString:@"offers"])
    {
        [self offers_view_calling];
    }
    else if([page_param isEqualToString:@"profile"])
    {
        [self Profile_VIEW_celling];
    }

}

#pragma Images_Action
-(void)calling_providers_view
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:1]];

    [self providers_view_calling];
}
-(void)calling_offers_view
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:2]];

    [self offers_view_calling];
}
-(void)calling_news_view
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:3]];

    [self news_VIEW_calling];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)remove_from
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
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
