//
//  ViewController.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /****************** Calling the set up view ***********************/

    [self setUP_VIEW];
    
}
#pragma setting the view of the components

-(void)setUP_VIEW
{
    
    /**************** settign te frame for view center **********************/
    
   // _VW_center.center=self.view.center;
    
    CGRect frameset = _BTN_guest.frame;
   
    
    
    
    /****************** setting the Button guest Text ***********************/
    
    NSString *str_name = @"Not a QIC-Anaya Customer? ----> Go";
    _BTN_guest.titleLabel.numberOfLines = 2;
    _BTN_guest.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_BTN_guest setTitle:str_name forState:UIControlStateNormal];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if(result.height <= 480)
    {
      _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 14];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height + 20;

    }
    else if(result.height <= 568)
    {
        _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 14];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height + 20;


    }
    else
    {
        _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 16];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height + 20;


    }
    _BTN_guest.frame = frameset;
    
    frameset = _BTN_register.frame;
    frameset.origin.y = _BTN_guest.frame.origin.y + _BTN_guest.frame.size.height + 20;
    _BTN_register.frame = frameset;
    
    
    
    /****************** setting the Button Login Border ***********************/
    
    _BTN_login.layer.borderWidth = 0.5f;
    _BTN_login.layer.cornerRadius = 2.0f;
    _BTN_login.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
    _BTN_register.layer.borderWidth = 0.5f;
    _BTN_register.layer.cornerRadius = 2.0f;
    _BTN_register.layer.borderColor = [UIColor whiteColor].CGColor;

    
    [_BTN_login addTarget:self action:@selector(login_action) forControlEvents:UIControlEventTouchUpInside];
    
    
}

#pragma mark LOGIN action

-(void)login_action
{
    [self performSegueWithIdentifier:@"login_home" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
