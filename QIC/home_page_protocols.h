//
//  home_page_protocols.h
//  QIC
//
//  Created by anumolu mac mini on 03/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol home_page_protocols <NSObject>

@optional

#pragma Sub categories action
-(void)sub_categories_action:(NSString *)str_status;
-(void)subcategories_back_action : (NSString *)str_back;

#pragma consultation offers
-(void)consultation_offers:(NSString *)str_status;
-(void)consultation_offers_back:(NSString *)str_back;
-(void)consultation_detail:(NSString *)str_status;
-(void)consultation_detail_back:(NSString *)str_back;


#pragma Detail_page action
-(void)detail_page_visibility:(NSString *)str_status;
-(void)detail_page_back:(NSString *)str_back;


#pragma Profile_page_action
-(void)dependets_ACTION:(NSString *)str_dependet;

#pragma Dependents_Action
-(void)back_ACTION : (NSString *)str_back;

#pragma Favourites_Action
-(void)favourites_ACTION;
-(void)favourites_back_ACTION:(NSString *)page_param;


#pragma Images Actions views calling
-(void)calling_providers_view;
-(void)calling_offers_view;
-(void)calling_news_view;

@end
