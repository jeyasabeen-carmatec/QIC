//
//  ViewController.m
//  QIC
//
//  Created by anumolu mac mini on 02/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "ViewController.h"
#import "APIHelper.h"

@interface ViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /****************** Calling the set up view ***********************/
    
    CGRect frameset = _VW_center.frame;
   
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if(result.height <= 480)
    {
         frameset.origin.y = self.view.frame.size.height/2-50;
        
    }
    else if(result.height <= 568)
    {
         frameset.origin.y = self.view.frame.size.height/2 -50;
    }
    else
    {
         frameset.origin.y = self.view.frame.size.height/2-50;
    }
     _VW_center.frame = frameset;
    
    //self.VW_center.center = self.view.center;
    
  //  self.VW_center.center = self.view.center;
    UITapGestureRecognizer *close_menu = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close_keyboard)];
    close_menu.delegate = self;
    [_VW_center addGestureRecognizer:close_menu];
     [self ALL_PATHS_API];
      [self Checka_Version];
  
}
-(void)viewWillAppear:(BOOL)animated
{
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
    
    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
   NSDictionary  *TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
    if([[TEMP_dict allKeys]count] > 1)
    {
        //Login-Screen-background.jpg
        _IMG_center.hidden = NO;
        [self.view addSubview:_IMG_center];
        _IMG_center.center = self.view.center;
        _VW_center.hidden = YES;
        [self calling_the_Company_API];
        _IMG_background.image = [UIImage imageNamed:@"1.png"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self performSegueWithIdentifier:@"login_home" sender:self];
              });
    }
    else{
        _IMG_background.image = [UIImage imageNamed:@"2.png"];

        _IMG_center.hidden = YES;
          _VW_center.hidden = NO;
        [self setUP_VIEW];
      
    }
    
}
#pragma setting the view of the components

-(void)setUP_VIEW
{
    
       _TXT_uname.text = @"";
    [_BTN_guest addTarget:self action:@selector(SIGN_UP_action) forControlEvents:UIControlEventTouchUpInside];
    
    /**************** settign te frame for view center **********************/
    
    //  _VW_center.center=self.view.center;
//    _TXT_uname.text =  @"";
//    _TXT_password.text = @"";
    
//     frameset = _VW_center.frame;
//    frameset.origin.y = 100;
//    _VW_center.frame = frameset;
    
   CGRect  frameset = _BTN_guest.frame;
   
    
    
    
    /****************** setting the Button guest Text ***********************/
    
    NSString *str_name = @"Not a QIC-Anaya Customer? Click here";
    _BTN_guest.titleLabel.numberOfLines = 2;
    _BTN_guest.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_BTN_guest setTitle:str_name forState:UIControlStateNormal];
    CGSize result = [[UIScreen mainScreen] bounds].size;
    
    if(result.height <= 480)
    {
      _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 14];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height +10;

    }
    else if(result.height <= 568)
    {
        _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 14];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height+10;


    }
    else
    {
        _BTN_guest.titleLabel.font =   [UIFont systemFontOfSize: 16];
        frameset.origin.y = _VW_center.frame.origin.y + _VW_center.frame.size.height + 20;


    }
    _BTN_guest.frame = frameset;
    
   
    
    
    /****************** setting the Button Login Border ***********************/
    
    _BTN_login.layer.borderWidth = 0.5f;
    _BTN_login.layer.cornerRadius = 2.0f;
    _BTN_login.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    
   

    
    [_BTN_login addTarget:self action:@selector(valdations_FOR_Text) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma Textfield dlegates
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
        [textField setTintColor:[UIColor colorWithRed:0.00 green:0.18 blue:0.35 alpha:1.0]];
        [UIView beginAnimations:nil context:NULL];
        self.view.frame = CGRectMake(0,-180,self.view.frame.size.width,self.view.frame.size.height);
        [UIView commitAnimations];
    
  }

-(void)textFieldDidEndEditing:(UITextField *)textField
{
  
   [UIView beginAnimations:nil context:NULL];
   self.view.frame = CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    [UIView commitAnimations];
   
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!string.length)
        return YES;
    
    if (textField == self.TXT_password || textField == self.TXT_uname)
    {
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
                                                            options:0
                                                              range:NSMakeRange(0, [newString length])];
        if (numberOfMatches == 0)
            return NO;
    }
    return YES;
}
#pragma gesture closing
-(void)close_keyboard
{
    [_TXT_uname resignFirstResponder];
    [_TXT_password resignFirstResponder];
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
        [_TXT_uname resignFirstResponder];
        [_TXT_password resignFirstResponder];
        [APIHelper start_animation:self];
        [self performSelector:@selector(login_action) withObject:nil afterDelay:0.01];

    }
    
}

#pragma mark LOGIN action


//-(void)login_action
//{
//
//    @try
//    {
//
//
//        NSString *str_QID = [NSString stringWithFormat:@"%@",_TXT_uname.text];
//         NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
//    NSString *url_str = [NSString stringWithFormat:@"%@login",str_image_base_URl];
//     //   NSString *str_Phone =[NSString stringWithFormat:@"%@",_TXT_password.text];
//    NSDictionary *parameters = @{@"memberId":str_QID};
//        [APIHelper postServiceCall:url_str andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
//
//
//        if(error)
//        {
//            [APIHelper stop_activity_animation:self];
//            [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
//
//        }
//        if(data)
//        {
//            NSDictionary *TEMP_dict = [data valueForKey:@"data"];
//            NSLog(@"The login customer Data:%@",TEMP_dict);
//             [APIHelper stop_activity_animation:self];
//
//            if([[TEMP_dict valueForKey:@"errMessage"] isEqualToString:@"Success"])
//            {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSMutableDictionary *dictMutable = [TEMP_dict mutableCopy];
//                    [dictMutable removeObjectsForKeys:[TEMP_dict allKeysForObject:[NSNull null]]];
//
////                    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
////
////                    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
////
////                    NSDictionary *TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
//
//                    NSString *str_ID = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"membershipNo"] ];
//
//                    [[NSUserDefaults standardUserDefaults] setValue:str_ID forKey:@"MEMBER_id"];
//                    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dictMutable] forKey:@"USER_DATA"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                  //  [APIHelper createaAlertWithMsg:@"Login suuccess" andTitle:@"Alert"];
//
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [self calling_the_Company_API];
//
//
//                                            });
//
//
//                });
//
//
//
//
//
//            }
//            else
//            {
//                [APIHelper stop_activity_animation:self];
//
//                 [APIHelper createaAlertWithMsg:@"Member not registered" andTitle:@""];
//
//            }
//
//
//
//        }
//        else{
//             [APIHelper stop_activity_animation:self];
//            [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
//
//        }
//
//    }];
//    }
//    @catch(NSException *exception)
//    {
//         [APIHelper stop_activity_animation:self];
//        NSLog(@"Exception from login api:%@",exception);
//    }
//
//}

-(void)login_action
{

    @try
    {


        NSString *str_name =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"UNAME"]];
        NSString *str_pwd =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"PWD"]];

        NSDictionary *headers = @{ @"username": str_name,
                                   @"password":str_pwd,
                                   @"Content-Type": @"application/json",
                                   @"Authorization": @"Basic ZjE4MWFjOGMtZjI5NC00NmM5LTljMzQtZTMzYzNjZjA5ZTA0OmE4Y2NlNjNkLTY1NzUtNDdmYy1iYzIyLTU2MWZkOGMyYWQ5Mw==",
                                   @"Cache-Control": @"no-cache",
                                   @"Postman-Token": @"187dcf1a-ed17-d8d6-34dd-c64ce78df93e" };
        NSString *str_QID = [NSString stringWithFormat:@"%@",_TXT_uname.text];
        NSString *url_str = [NSString stringWithFormat:@"https://www.api.qic-insured.com/anaya-mobile/memberPortalLogin?company=001"];
        NSDictionary *parameters = @{@"memberId":str_QID,@"phone":@"33156672"};
        [APIHelper login_postServiceCall:url_str andParams:parameters:headers completionHandler:^(id  _Nullable data, NSError * _Nullable error) {

            if(error)
            {
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];

            }
            if(data)
            {
                NSDictionary *TEMP_dict = data;
                NSLog(@"The login customer Data:%@",TEMP_dict);
                [APIHelper stop_activity_animation:self];

                if([[TEMP_dict valueForKey:@"errMessage"] isEqualToString:@"Success"])
                {

                        NSMutableDictionary *dictMutable = [TEMP_dict mutableCopy];
                        [dictMutable removeObjectsForKeys:[TEMP_dict allKeysForObject:[NSNull null]]];

                      //  NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];

                    //    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];

                   //     NSDictionary *TEMP_dicts = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];

                        NSString *str_ID = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"membershipNo"] ];

                        [[NSUserDefaults standardUserDefaults] setValue:str_ID forKey:@"MEMBER_id"];
                        [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:dictMutable] forKey:@"USER_DATA"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        //  [APIHelper createaAlertWithMsg:@"Login suuccess" andTitle:@"Alert"];
                         dispatch_async(dispatch_get_main_queue(), ^{
                        [self calling_the_Company_API];


                    });





                }
                else
                {
                    [APIHelper stop_activity_animation:self];

                    [APIHelper createaAlertWithMsg:@"Please check QID number" andTitle:@"Alert"];

                }



            }
            else{
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];

            }

        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
    }

}
#pragma Storing data in Db
-(void)calling_the_Company_API
{
    //customerInfo
       NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
    NSString *str_URL = [NSString stringWithFormat:@"%@customerInfo",str_image_base_URl];
    @try
    {
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
        
        NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSDictionary *TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];

        NSDictionary *parameters = TEMP_dict;
        [APIHelper postServiceCall:str_URL andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
            }
            if(data)
            {
                NSDictionary *TEMP_dict = data;
                NSLog(@"The login customer Data:%@",TEMP_dict);
    
                NSString *str_code = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"code"]];
                NSString *str_count = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"favorites_count"]];
                NSString *str_notification_count = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"notification_count"]];
                str_count = [str_count stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
                str_count = [str_count stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

                str_notification_count = [str_notification_count stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
                 str_notification_count = [str_notification_count stringByReplacingOccurrencesOfString:@"(null)" withString:@""];

                
                
                if([str_code isEqualToString:@"1"])
                {
                     
                    [[NSUserDefaults standardUserDefaults]  setValue:str_count forKey:@"wish_count"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [[NSUserDefaults standardUserDefaults]  setValue:str_notification_count forKey:@"noifi_count"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSString *dev_TOK = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEV_TOK"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        
                        if (dev_TOK)
                        {
                            
                            [self register_device_token];
                        }
                        else
                        {
                            
                            [[NSNotificationCenter defaultCenter] addObserver:self
                                                                     selector:@selector(tokenAvailableNotification:)
                                                                         name:@"NEW_TOKEN_AVAILABLE" object:nil];
                            
                            [APIHelper stop_activity_animation:self];
                        }
                        
                        
                         [self performSegueWithIdentifier:@"login_home" sender:self];
                    });
                    
                    
                }
                else
                {
                     [APIHelper stop_activity_animation:self];
                    [APIHelper createaAlertWithMsg:@"Some thing went wrong" andTitle:@"Alert"];
                    
                }
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
      [APIHelper stop_activity_animation:self];
      [APIHelper createaAlertWithMsg:@"Some thing went wrong" andTitle:@"Alert"];
        
    }
    
    
}

#pragma mark - Register Push Notification
- (void)tokenAvailableNotification:(NSNotification *)notification {
    
    @try
    {
        
        
     NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
        NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
        NSString *url_str = [NSString stringWithFormat:@"%@saveDeviceInfo",str_image_base_URl];
        
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEV_TOK"];
        token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSDictionary *parameters = @{@"customer_id":str_member_ID,@"device_type":@"iphone",@"device_token":token};
        [APIHelper postServiceCall:url_str andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                
            }
            [APIHelper stop_activity_animation:self];
            if(data)
            {
                NSDictionary *TEMP_dict = [data valueForKey:@"data"];
                NSLog(@"The TOken api customer Data:%@",TEMP_dict);
                
                
              
                
            }
            else{
                [APIHelper stop_activity_animation:self];
                [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                
            }
            
        }];
    }
    @catch(NSException *exception)
    {
        [APIHelper stop_activity_animation:self];
        NSLog(@"Exception from login api:%@",exception);
        [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];

    }
    
}

#pragma All api paths calling
-(void)ALL_PATHS_API
{
    
 [APIHelper stop_activity_animation:self];
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
       NSString *URL_STR = [NSString stringWithFormat:@"%@ciqAllPathLinks",IMAGE_URL];
        
        NSURL *urlProducts=[NSURL URLWithString:URL_STR];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:urlProducts];
        [request setHTTPMethod:@"GET"];
        [request setHTTPShouldHandleCookies:NO];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSData *aData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        [APIHelper stop_activity_animation:self];
        if(aData)
        {
          NSDictionary  *JSON_response_dic=(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            NSLog(@"%@",JSON_response_dic);
             NSString *str_code = [NSString stringWithFormat:@"%@",[JSON_response_dic valueForKey:@"msg"]];
            
            if([str_code isEqualToString:@"Success"])
            {

                [[NSUserDefaults standardUserDefaults] setValue:[[JSON_response_dic valueForKey:@"url"]valueForKey:@"username"] forKey:@"UNAME"];
                [[NSUserDefaults standardUserDefaults] setValue:[[JSON_response_dic valueForKey:@"url"]valueForKey:@"password"] forKey:@"PWD"];
            [[NSUserDefaults standardUserDefaults] setValue:[[JSON_response_dic valueForKey:@"url"]valueForKey:@"api_url"] forKey:@"SERVER_URL"];
                
            [[NSUserDefaults standardUserDefaults] setValue:[[JSON_response_dic valueForKey:@"url"]valueForKey:@"base_url"] forKey:@"IMAGE_URL"];
                
            [[NSUserDefaults standardUserDefaults] synchronize];
                
                
            }
        }
        else
        {
            NSDictionary *dictin = [[NSDictionary alloc]initWithObjectsAndKeys:@"Nodata",@"error", nil];
            NSLog(@"%@",dictin);
        }
    }
    @catch(NSException *Exception)
    {
        
    }
  
}



#pragma Sign UP action
-(void)SIGN_UP_action
{
    //login_sign_UP
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.qic-anaya.com"]];

   // [self performSegueWithIdentifier:@"login_sign_UP" sender:self];
//    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"Sign_up_URL"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma Checking the version
-(void)Checka_Version
{
    @try
    {
    NSString *str_code = [[NSLocale autoupdatingCurrentLocale] objectForKey:NSLocaleCountryCode];
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://itunes.apple.com/%@/lookup?id=1377090050",str_code]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (!error) {
                                   NSError* parseError;
                                   NSDictionary *appMetadataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&parseError];
                                   NSArray *resultsArray = (appMetadataDictionary)?[appMetadataDictionary objectForKey:@"results"]:nil;
                                   NSDictionary *resultsDic = [resultsArray firstObject];
                    
                                   if (resultsDic) {
                                       // compare version with your apps local version
                                       NSString *iTunesVersion = [resultsDic objectForKey:@"version"];
                                       
                                       NSString *appVersion = @"1.0.1";
                                       
                                       NSLog(@"itunes version = %@\nAppversion = %@",iTunesVersion,appVersion);
                                     
                                       
                                       if (iTunesVersion && [appVersion compare:iTunesVersion] != NSOrderedSame) {
                                           
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Version Updated %@",iTunesVersion] message:[resultsDic valueForKey:@"releaseNotes"] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Update",@"Cancel", nil];
                                           alert.tag = 123456;
                                           [alert show];
                                         
                                       }
                                   }
                               } else {
                                   // error occurred with http(s) request
                                   NSLog(@"error occurred communicating with iTunes");
                               }
                           }];
        }
    @catch(NSException *exception)
    {
        
    }
    
}
-(void)register_device_token
{
   
        @try
        {
            
            
       NSString  *str_member_ID =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"MEMBER_id"]];
            NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
            NSString *url_str = [NSString stringWithFormat:@"%@saveDeviceInfo",str_image_base_URl];
       
            NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"DEV_TOK"];
            token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
           // [APIHelper createaAlertWithMsg:token andTitle:@"Alert"];
            NSDictionary *parameters = @{@"customer_id":str_member_ID,@"device_type":@"iphone",@"device_token":token};
            [APIHelper postServiceCall:url_str andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
                
                
                if(error)
                    
                    
                {
                    [APIHelper stop_activity_animation:self];
                    [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                    
                }
                if(data)
                {
                    NSDictionary *TEMP_dict = data;
                    NSLog(@"The TOken api customer Data:%@",TEMP_dict);
                    [APIHelper stop_activity_animation:self];
                    
                   
                }
                else{
                    [APIHelper stop_activity_animation:self];
                    [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
                    
                }
                
            }];
        }
        @catch(NSException *exception)
        {
            [APIHelper stop_activity_animation:self];
            
            [APIHelper createaAlertWithMsg:@"Server Connection error" andTitle:@"Alert"];
        }
        
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
