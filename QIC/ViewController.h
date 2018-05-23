//
//  ViewController.h
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

#pragma Mark Textfields

@property(nonatomic,weak) IBOutlet UITextField *TXT_uname;
@property(nonatomic,weak) IBOutlet UITextField *TXT_password;

#pragma Mark Buttons

@property(nonatomic,weak) IBOutlet UIButton *BTN_login;
@property(nonatomic,weak) IBOutlet UIButton *BTN_guest;

#pragma Mark View center

@property(nonatomic,weak) IBOutlet UIView *VW_center;
@property(nonatomic,weak) IBOutlet UIImageView *IMG_center;


@end

