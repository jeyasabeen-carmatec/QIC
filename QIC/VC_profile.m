//
//  VC_profile.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_profile.h"
#import "profile_cell.h"
#import "Profile_langugage_cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "APIHelper.h"

@interface VC_profile ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    CGRect frameset;
    NSArray *ARR_icons;
    NSArray *DICT_profile;
    NSDictionary *TEMP_dict;
    UIPickerView *Lang_picker;
    NSString *localFilePath;
    
}

@end

@implementation VC_profile

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    ARR_icons = [NSArray arrayWithObjects:@"profile-icon.png",@"fingerprint.png",@"Vector-Smart-Object.png",@"validity.png",@"dependent.png",@"Vector-Smart-Object.png",@"change-language.png",@"About-QIC.png",@"privacy-policy.png",@"terms-&-condition.png", nil];
    
    ARR_icons = [NSArray arrayWithObjects:@"profile-icon.png",@"fingerprint.png",@"Vector-Smart-Object.png",@"validity.png",@"dependent.png",@"Vector-Smart-Object.png",@"terms-&-condition.png",@"logout.png", nil];
    [_BTN_camera addTarget:self action:@selector(take_Picture) forControlEvents:UIControlEventTouchUpInside];

   
    
    [self set_UP_DATA];
    
    [self set_UP_VIEW];
    [self Image_API_Calling];
    
}
#pragma set up DATA

-(void)set_UP_DATA
{
    @try
    {
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];

    NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];

    TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
        
        
        
    
    NSString *str_name = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"memberName"]]];
     NSString *str_QID = [NSString stringWithFormat:@"QID : %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"membershipNo"]]];
    NSString *str_MID = [NSString stringWithFormat:@"Membership ID : %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"membershipNo"]]];
        
   NSString *str_fromdate = [NSString stringWithFormat:@"%@",[self getting_from_date:[[TEMP_dict valueForKey:@"validityFromDate"] doubleValue]]];
    
   NSString * str_to_date = [NSString stringWithFormat:@"%@",[self getting_from_date:[[TEMP_dict valueForKey:@"validityToDate"] doubleValue]]];
    
    NSString *str_validity = [NSString stringWithFormat:@"Validity : %@ to %@",str_fromdate,str_to_date];
//        DICT_profile = [NSArray arrayWithObjects:str_name,str_QID,str_MID,str_validity,@"Depenedents",@"Health Card",@"Change language",@"About QIC",@"Privacy Policy",@"Terms and Conditions", nil];

    
    DICT_profile = [NSArray arrayWithObjects:str_name,str_QID,str_MID,str_validity,@"Depenedents",@"Health Card",@"Terms and Conditions",@"Logout", nil];
    }
    @catch(NSException *exception)
    {
        NSLog(@"The exception from setting the data:%@",exception);
    }
    }
#pragma set up view 

-(void)set_UP_VIEW
{
   
    _BTN_camera.layer.cornerRadius = _BTN_camera.frame.size.width/2;
    _BTN_camera.layer.masksToBounds = YES;
   // _LBL_profile_name.numberOfLines = 0;
   // [_LBL_profile_name sizeToFit];
    
    @try
    {
    _LBL_profile_name.text =[NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"memberName"]]];

    _LBL_mobile_number.text =[NSString stringWithFormat:@"  %@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"mobileNo"]]];
    }
    @catch(NSException *exception)
    {
        NSLog(@"Exception from User_name,phone_number");
    }
    
    
  //  [_LBL_mobile_number sizeToFit];
   //  _LBL_mobile_number.numberOfLines = 0;
    
    
    
    
   
    frameset = _LBL_mobile_number.frame;
    frameset.origin.y = _LBL_profile_name.frame.origin.y + _LBL_profile_name.frame.size.height + 4;
    _LBL_mobile_number.frame = frameset;
    
    frameset = _TBL_profile.frame;
    frameset.origin.y = _LBL_mobile_number.frame.origin.y + _LBL_mobile_number.frame.size.height + 20;
    _TBL_profile.frame = frameset;
    
    
    
    frameset =_VW_main.frame;
    frameset.size.height = _Scroll_contents.frame.size.height - 50;
    frameset.size.width = _Scroll_contents.frame.size.width;
    _VW_main.frame =  frameset;
    [_Scroll_contents addSubview:_VW_main];
    
    _VW_IMG_background.layer.cornerRadius = _VW_IMG_background.frame.size.width/2;
    _IMG_prfoile_image.layer.cornerRadius = _IMG_prfoile_image.frame.size.width/2;
    _IMG_prfoile_image.layer.masksToBounds = YES;
    
     [self.delegate hide_over_lay];
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
     [_Scroll_contents layoutIfNeeded];
    
    _Scroll_contents.contentSize= CGSizeMake(_Scroll_contents.frame.size.width, _TBL_profile.frame.origin.y +  _TBL_profile.contentSize.height);
    
    
}
#pragma Tableview delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ARR_icons.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    profile_cell *cell = (profile_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"profile_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    


    
    cell.IMG_icon.image = [UIImage imageNamed:[ARR_icons objectAtIndex:indexPath.row]];
    cell.LBL_name.text  = [DICT_profile objectAtIndex:indexPath.row];
    cell.BTN_arrow.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    
    if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"] || [[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Change language"])
    {
         cell.BTN_arrow.hidden = NO;
      
    }
    
    

    
       return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Depenedents"])
    {
        if([[TEMP_dict valueForKey:@"mebList"] isKindOfClass:[NSArray class]] || TEMP_dict.count > 1 )
        {
            [self.delegate dependets_ACTION:@"profile"];
        }
        else{
            [APIHelper createaAlertWithMsg:@"No Dependents Found" andTitle:@""];
        }
    }
   else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Health Card"])
    {
        [self.delegate health_card_ACTION];
    }
   else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Privacy Policy"])
   {
        NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"]];
       NSString *str_URL = [NSString stringWithFormat:@"%@pages/privacyPolicy",str_image_base_URl];
       [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];

       [[NSUserDefaults standardUserDefaults] setValue:@"PRIVACY POLICY" forKey:@"header_val"];
       [[NSUserDefaults standardUserDefaults] synchronize];
       
       
       
       [self.delegate static_page_view_call];
   }
     else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Logout"])
     {
//         [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
//         [[UIApplication sharedApplication] cancelAllLocalNotifications];
         [self dismissViewControllerAnimated:YES completion:nil];
     }
    else if([[DICT_profile objectAtIndex:indexPath.row] isEqualToString:@"Terms and Conditions"])
    {
            NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"IMAGE_URL"]];
        NSString *str_URL = [NSString stringWithFormat:@"%@pages/termsAndConditions",str_image_base_URl];
        [[NSUserDefaults standardUserDefaults]  setValue:str_URL forKey:@"Static_URL"];

        [[NSUserDefaults standardUserDefaults] setValue:@"TERMS AND CONDITIONS" forKey:@"header_val"];
        [[NSUserDefaults standardUserDefaults] synchronize];
         [self.delegate static_page_view_call];

        
    }


    

}


#pragma mark - UIPickerViewDataSource Delegate Methods


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
   
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    
    
    return 1;
}

#pragma mark - UIPickerViewDelegate

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
        
        return @"Englsih";
    
   }


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
}
#pragma Picker Button actions
-(void)close_action
{
    [_TBL_profile reloadData];
}
-(void)done_action
{
    [_TBL_profile reloadData];

}

#pragma Converting the Time stamps

-(NSString*)getting_from_date:(double )timeStamp{
    NSTimeInterval timeInterval=timeStamp/1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString=[dateformatter stringFromDate:date];
    return dateString;
}
#pragma Take paicture form camera button
-(void)take_Picture
{
    UIActionSheet *actionSheet;
    
  
        actionSheet = [[UIActionSheet alloc] initWithTitle:@"Pick From"
                                                  delegate:self
                                         cancelButtonTitle:@"Cancel"
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:@"Camera", @"Gallery", nil];
        
   
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (buttonIndex == 0)
    {
        
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
            
        }
        else{
            [APIHelper createaAlertWithMsg:@"Camera is not Available" andTitle:@""];
        }
        
    }
    else if (buttonIndex == 1)
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:nil];
    }
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    _IMG_prfoile_image.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *chosenImage = _IMG_prfoile_image.image;
    _IMG_prfoile_image.image = chosenImage;
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        
        NSData *imageData = UIImagePNGRepresentation(chosenImage);
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *imagePath =[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",@"cached"]];
        
        NSLog(@"pre writing to file");
        if (![imageData writeToFile:imagePath atomically:NO])
        {
            NSLog(@"Failed to cache image data to disk");
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please retry" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
        else
        {
            NSLog(@"the cachedImagedPath is %@",imagePath);
            localFilePath = imagePath;
        }
    }
    else
    {
    NSURL *imagePath = [editingInfo objectForKey:@"UIImagePickerControllerReferenceURL"];
    NSString *imageName = [imagePath lastPathComponent];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    localFilePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    }
    [self uploadImage:image];
    
}



- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma Storing data in Db

-(void)Image_API_Calling
{
    //customerInfo
    NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
    NSString *str_URL = [NSString stringWithFormat:@"%@profilePic",str_image_base_URl];
    @try
    {
        
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"USER_DATA"];
        
        NSDictionary *retrievedDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        NSDictionary *TEMP_dict = [[NSDictionary alloc] initWithDictionary:retrievedDictionary];
        NSString *str_member_ID = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"membershipNo"]];
        NSDictionary *parameters = @{@"membershipNo":str_member_ID};
        [APIHelper postServiceCall:str_URL andParams:parameters completionHandler:^(id  _Nullable data, NSError * _Nullable error) {
            
            if(error)
            {
                [APIHelper stop_activity_animation:self];
            }
            if(data)
            {
                NSDictionary *TEMP_dict = data;
                NSLog(@"The profile Data:%@",TEMP_dict);
                [APIHelper stop_activity_animation:self];
                
                
                NSString *str_code = [NSString stringWithFormat:@"%@",[TEMP_dict valueForKey:@"code"]];
                
                
                if([str_code isEqualToString:@"1"])
                {
                    NSString *str_image = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"url"]]];
                    str_image = [str_image stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                    
                    [_IMG_prfoile_image sd_setImageWithURL:[NSURL URLWithString:str_image]
                                      placeholderImage:[UIImage imageNamed:@"upload-27.png"]];
                    
                }
                else
                {
                    
                    [APIHelper createaAlertWithMsg:@"Some thing went wrong" andTitle:@"Alert"];
                    
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

-(void)uploadImage:(UIImage *)yourImage
{
    [APIHelper start_animation:self];
    
     NSString *str_member_ID = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[TEMP_dict valueForKey:@"membershipNo"]]];
    
    NSData *imageData = UIImageJPEGRepresentation(yourImage, 1.0);//UIImagePNGRepresentation(yourImage);
        NSString *str_image_base_URl = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"SERVER_URL"]];
    NSString *urlString =  [NSString stringWithFormat:@"%@profileImgUpload",str_image_base_URl];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    localFilePath = [localFilePath stringByReplacingOccurrencesOfString:@"JPG" withString:@"jpg"];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile-pic\"; filename=\"%@\"\r\n",localFilePath] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"customer_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"%@",str_member_ID]dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    

   
    
    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    //[body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"logo\"; filename=\"%@\"\r\n", @"serser.jpg"]] dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[[NSString stringWithString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"profile-pic\"; filename=\"profile-pic\"\r\n"]] dataUsingEncoding:NSUTF8StringEncoding]];
//
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[NSData dataWithData:imageData]];
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSError *err;
    
    NSData *data= [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&err];
    
    if (err) {
    
        NSLog(@"%@",[err localizedDescription]);
    }
    [APIHelper stop_activity_animation:self];
    
    if (data)
    {
        NSMutableDictionary *jsonObject=[NSJSONSerialization
                                         JSONObjectWithData:data
                                         options:NSJSONReadingMutableLeaves
                                         error:nil];
        NSLog(@"jsonObject  %@",jsonObject);
        [APIHelper createaAlertWithMsg:[jsonObject valueForKey:@"mes"] andTitle:@""];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
