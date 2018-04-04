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
    frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height + 40;
    _BTN_guest.frame = frameset;
    
    
    
    /****************** setting the Button guest Text ***********************/
    
    NSString *str_name = @"If you are not a registered QIC - Anaya product customer\nClick here  --->";
    _BTN_guest.titleLabel.numberOfLines = 2;
    _BTN_guest.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_BTN_guest setTitle:str_name forState:UIControlStateNormal];
    
    
    
    /****************** setting the Button Login Border ***********************/
    
    _BTN_login.layer.borderWidth = 0.5f;
    _BTN_login.layer.cornerRadius = 2.0f;
    _BTN_login.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
