//
//  ViewController.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "ViewController.h"
#import "APIHelper.h"

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
    _TXT_uname.text =  @"28535632996";
    
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

    
    [_BTN_login addTarget:self action:@selector(valdations_FOR_Text) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma Validation checking

-(void)valdations_FOR_Text
{
    NSString *str_msg;
   if([_TXT_uname.text isEqualToString:@""])
   {
       str_msg =  @"Please enter QID number";
   }
    if(str_msg)
    {
        [APIHelper createaAlertWithMsg:str_msg andTitle:@"Alert"];
    }
    else
    {
        [APIHelper start_animation:self];
        [self performSelector:@selector(login_action) withObject:nil afterDelay:0.01];

    }
    
}

#pragma mark LOGIN action
-(void)login_action
{
    
    @try
    {
    NSString *str_QID = [NSString stringWithFormat:@"%@",_TXT_uname.text];
    NSString *url_str = [NSString stringWithFormat:@"https://www.devapi.anoudapps.com/anaya/memberPortalLogin?company=001"];
    NSDictionary *parameters = @{@"memberId":str_QID};
    [APIHelper postServiceCall:url_str andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
        
        if(error)
        {
            [APIHelper stop_activity_animation:self];
        }
        if(data)
        {
            NSDictionary *TEMP_dict = data;
            NSLog(@"The login customer Data:%@",TEMP_dict);
             [APIHelper stop_activity_animation:self];
            
            if([[TEMP_dict valueForKey:@"errMessage"] isEqualToString:@"Success"])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"login_home" sender:self];
                    [APIHelper createaAlertWithMsg:@"Login suuccess" andTitle:@"Alert"];


                });
                
                
                NSMutableDictionary *dictMutable = [TEMP_dict mutableCopy];
                [dictMutable removeObjectsForKeys:[TEMP_dict allKeysForObject:[NSNull null]]];
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dictMutable] forKey:@"USER_DATA"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
            else
            {
                
                 [APIHelper createaAlertWithMsg:@"Please check QID number" andTitle:@"Alert"];

            }
        

            
        }

    }];
    }
    @catch(NSException *exception)
    {
         [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
