//
//  VC_categories.h
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "home_page_protocols.h"

@interface VC_categories : UIViewController

#pragma mark Collection categories

@property(nonatomic,weak) IBOutlet UICollectionView *collection_categoriesl;
@property(nonatomic,assign) id <home_page_protocols> delegate;


@end
