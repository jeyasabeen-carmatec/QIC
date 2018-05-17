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
#import "VC_health_card.h"
#import "VC_static_pages.h"
#import "APIHelper.h"
#import "VC_search.h"
#import "VC_offers_search.h"
#import "VC_Notifications.h"


@interface VC_home ()<UITabBarDelegate>
{
    float scroll_ht;
    UIView *vw_over_lay;
    
    
}

@end

@implementation VC_home

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /********************* setting the delegates ***************************/
    scroll_ht = _VW_main.frame.size.height;
    vw_over_lay = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    vw_over_lay.backgroundColor = [UIColor clearColor];
    [self.TAB_menu addSubview:vw_over_lay];
    vw_over_lay.hidden = YES;
    
    [self highlight_IMAGE];
    [self tab_BAR_set_UP];
     [self HOme_view_calling];
    //[self favourites_API_call];
     [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:0]];
    
    
}
#pragma mark highight the Tab menu indicator image

-(void)highlight_IMAGE
{
    /*************************** Setting the selector image for tab image  ***************************/
    
    CGFloat highlightedWidth = self.view.frame.size.width/_TAB_menu.items.count;
    [_TAB_menu setItemWidth:highlightedWidth];
    CGRect rect = CGRectMake(0, 9, highlightedWidth, _TAB_menu.frame.size.height+18);
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if (screenSize.height == 812.0f)
        rect = CGRectMake(0, 0, highlightedWidth, _TAB_menu.frame.size.height+32);

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
    @try
    {
    if([item.title isEqualToString:@"Home"])
    {
        /************** calling home view  ******************/
       
        
         vw_over_lay.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"home" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        
        [self HOme_view_calling];
       
        
    }
    
    else  if([item.title isEqualToString:@"Providers"])
    {
        
        /************** calling providers view  ******************/
         vw_over_lay.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"providers" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        [self providers_view_calling];
        
     
        
    }
    else  if([item.title isEqualToString:@"Articles"])
    {
        /************** calling News view  ******************/
        
        vw_over_lay.hidden = NO;
        [[NSUserDefaults standardUserDefaults] setValue:@"news" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        


        [self news_VIEW_calling];
    
    }
    else  if([item.title isEqualToString:@"Offers"])
    {
        /************** calling Offers view  ******************/
        vw_over_lay.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"offers" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];


        [self offers_view_calling];
     
    }
    else  if([item.title isEqualToString:@"Profile"])
    {
        /************** creating objet for Profile view controller and and grabbing that view  ******************/
        
         vw_over_lay.hidden = NO;
        
        [[NSUserDefaults standardUserDefaults] setValue:@"profile" forKey:@"tab_param"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        [self Profile_VIEW_celling];
     
    }

    }
    @catch(NSException *exception)
    {
        
    }
    
}

#pragma Home page view calling

-(void)HOme_view_calling
{
    @try
    {
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:0]];

    /************** creating objet for Home view controller and and grabbing that view  ******************/
    [[NSUserDefaults standardUserDefaults] setValue:@"home" forKey:@"tab_param"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    VC_home_tab *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_home_tab"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = scroll_ht;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];
    
   
    }
    @catch(NSException *exception)
    {
        
    }

}

#pragma Providers view callig

-(void)providers_view_calling
{
    @try
    {
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:1]];

    VC_categories *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_categoies"];
    categorie_vw.delegate= self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    [categorie_vw.collection_categoriesl reloadData];
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

    }
    @catch(NSException *exception)
    {
        
    }

}

#pragma Offers view calling

-(void)offers_view_calling
{
    @try
    {
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:2]];

    VC_offers *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_offers"];
    categorie_vw.delegate = self;
    
        CGRect frameset = categorie_vw.view.frame;
        frameset.origin.x =  0;
        frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
        frameset.size.height = _VW_main.frame.size.height ;
        frameset.size.width = self.view.frame.size.width;
        categorie_vw.view.frame =  frameset;
//        [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];
    

    }
    @catch(NSException *exception)
    {
        
    }
    
   
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
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

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
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

    
}
/**************** consulatation back ***********************/
-(void)consultation_offers_back:(NSString *)str_back
{
    NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];
    if([str isEqualToString:@"home"])
    {
        [self HOme_view_calling];
    }
    else{
        [self offers_view_calling];

    }

}
-(void)consultation_detail:(NSString *)str_status
{
  //  [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:1]];
    [self detail_PAGE];
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.TAB_menu invalidateIntrinsicContentSize];
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
    else if([str_back isEqualToString:@"home"])
    {
        [self HOme_view_calling];
    }
    else if([str_back isEqualToString:@"provider_search"])
    {
        [self providers_view_calling];
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
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

}

#pragma Profile View Pages calling
-(void)Profile_VIEW_celling
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:4]];

    VC_profile *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_profile"];
    [categorie_vw.TBL_profile reloadData];
    
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];


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
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

}
-(void)back_ACTION:(NSString *)str_dependet
{
    [self Profile_VIEW_celling];
}

#pragma News View Calling
-(void)news_VIEW_calling
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:3]];

    /************** creating objet for News view controller and and grabbing that view  ******************/
    
    VC_news *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_news"];
    categorie_vw.delegate = self;
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height =scroll_ht ;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];
 
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
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

    
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

    [self detail_PAGE];
}
-(void)calling_offers_view
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:2]];

    [self offers_view_calling];
}
-(void)calling_news_view:(NSString *)str_param
{
    [self.TAB_menu setSelectedItem:[[self.TAB_menu items] objectAtIndex:3]];

    if([str_param isEqualToString:@"news_detail"])
    {
        [self static_page_view_call];
    }
    else{
        [self news_VIEW_calling];
 
    }

}
-(void)calling_category_view_all
{
    [self providers_view_calling];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    @try
    {
        
    }
    @catch(NSException *exception)
    {
        
    }
    
}
-(void)remove_from
{
    UIViewController *vc = [self.childViewControllers lastObject];
    [vc willMoveToParentViewController:nil];
    [vc.view removeFromSuperview];
    [vc removeFromParentViewController];
}

#pragma Health card back_action

-(void)health_card_ACTION
{
    VC_health_card *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_health_card"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

}
-(void)calling_profile_view
{
    [self Profile_VIEW_celling];
}
#pragma Static pages action
-(void)static_page_back:(NSString *)str_param
{
    if([str_param isEqualToString:@"news"])
    {
        [self news_VIEW_calling];
    }
    else if([str_param isEqualToString:@"top news"])
    {
        [self HOme_view_calling];
    }
    else{
         [self Profile_VIEW_celling];
    }
}
#pragma calling static_PAGE_VIEW
-(void)static_page_view_call
{
    VC_static_pages *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_static_page"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

}
#pragma calling_search_VIEW
-(void)search_VIEW_calling
{
    VC_search *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_search"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

    
}
-(void)offers_search_page_calling
{
    VC_offers_search *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_search_offers"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
//    [UIView transitionWithView:self.VW_main
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionFlipFromLeft
//                    animations:^{
                        [self.VW_main addSubview:categorie_vw.view];
                        
                        [self addChildViewController:categorie_vw];
                        [categorie_vw didMoveToParentViewController:self];
                        categorie_vw.definesPresentationContext = YES;
//                    } completion:nil
//     ];

    
}
-(void)offers_search_back
{
    [self offers_view_calling];
}
-(void)provider_search_back:(NSString *)str_back
{
    if([str_back isEqualToString:@"home"])
    {
        [self HOme_view_calling];
    }
    else{
        [self providers_view_calling];
    }
   
}
#pragma hide_over_lay
-(void)hide_over_lay
{
    vw_over_lay.hidden = YES;
}
#pragma Notifications view calling
-(void)notification_view_call
{
    VC_Notifications *categorie_vw = [self.storyboard instantiateViewControllerWithIdentifier:@"vc_search_offers"];
    //  [categorie_vw.TBL_profile reloadData];
    categorie_vw.delegate = self;
    
    CGRect frameset = categorie_vw.view.frame;
    frameset.origin.x =  0;
    frameset.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frameset.size.height = _VW_main.frame.size.height;
    frameset.size.width = self.view.frame.size.width;
    categorie_vw.view.frame =  frameset;
    //    [UIView transitionWithView:self.VW_main
    //                      duration:0.5
    //                       options:UIViewAnimationOptionTransitionFlipFromLeft
    //                    animations:^{
    [self.VW_main addSubview:categorie_vw.view];
    
    [self addChildViewController:categorie_vw];
    [categorie_vw didMoveToParentViewController:self];
    categorie_vw.definesPresentationContext = YES;
    //                    } completion:nil
    //     ];

}
-(void)notification_back
{
    [self HOme_view_calling];
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
