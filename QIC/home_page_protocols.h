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



@end
