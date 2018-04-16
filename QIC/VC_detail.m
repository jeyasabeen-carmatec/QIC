//
//  VC_detail.m
//  QIC
//
//  Created by anumolu mac mini on 04/04/18.
//  Copyright © 2018 anumolu mac mini. All rights reserved.
//

#import "VC_detail.h"
#import "HMSegmentedControl.h"
#import "offers_cell.h"

@interface VC_detail ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    float scroll_ht;
    NSMutableArray *Arr_ofrs_list;
    CLLocationManager *locationManager;
}
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;

@end

@implementation VC_detail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self SET_UP_VIEW];
   }
#pragma setiing the frames for compnents

-(void)SET_UP_VIEW
{
    Arr_ofrs_list = [[NSMutableArray alloc]init];
    NSDictionary *temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Consultations",@"key1",@"20%",@"key2",nil];
    [Arr_ofrs_list addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Procedures",@"key1",@"30%",@"key2", nil];
    [Arr_ofrs_list addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Pharmacy",@"key1",@"40%",@"key2", nil];
    [Arr_ofrs_list addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Laser",@"key1",@"20%",@"key2", nil];
    [Arr_ofrs_list addObject:temp_dict];
    
    temp_dict=[NSDictionary dictionaryWithObjectsAndKeys:@"Cosmetic",@"key1",@"30%",@"key2", nil];
    [Arr_ofrs_list addObject:temp_dict];
    

    
    
    _IMG_center_image.layer.cornerRadius = _IMG_center_image.frame.size.width/2;
    _IMG_center_image.layer.masksToBounds =  YES;
    
    _LBL_center_name.text = @"AL SHAMI MEDICAL CENTER";
   /* NSString *str_center_name =@"Al shami medical center";
    NSString *str_designaton = @"Dentist";
    NSString *str_address = @"Wadi Al Utooria Strret,Khaled.";
    NSString *str_PHONE = @"PHONE:1234567891";
    
    NSString *str_addres = [NSString  stringWithFormat:@"%@\n%@\n%@\n%@",str_center_name,str_designaton,str_address,str_PHONE];
    
    if ([_TXT_VW_address respondsToSelector:@selector(setAttributedText:)])
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 5.0f;
        paragraphStyle.maximumLineHeight = 5.0f;
        paragraphStyle.minimumLineHeight = 5.0f;

        
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName:_TXT_VW_address.textColor,
                                  NSFontAttributeName: _TXT_VW_address.font,
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  };
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:str_addres attributes:attribs];
        

      [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:15.0],NSForegroundColorAttributeName:[UIColor colorWithRed:0.33 green:0.72 blue:0.78 alpha:1.0],}range:[str_addres rangeOfString:str_center_name] ];
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:15.0],NSForegroundColorAttributeName:[UIColor lightGrayColor],}range:[str_addres rangeOfString:str_designaton] ];
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:15.0],NSForegroundColorAttributeName:[UIColor lightGrayColor],}range:[str_addres rangeOfString:str_address] ];
        
        [attributedText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Futura-Book" size:15.0],NSForegroundColorAttributeName:[UIColor lightGrayColor],}range:[str_addres rangeOfString:str_PHONE] ];
        
        
        
        _TXT_VW_address.attributedText = attributedText;
    }
    else{
        _TXT_VW_address.text = str_address;
    }*/

    
    
    
   // [_LBL_center_name sizeToFit];
    
    _LBL_designation.text = @"Dentist";
    //[_LBL_designation sizeToFit];
    CGRect frameset = _LBL_designation.frame;
    frameset.origin.y = _LBL_center_name.frame.origin.y + _LBL_center_name.frame.size.height+4;
    _LBL_designation.frame = frameset;
    
    
    _LBL_address.text = @"Wadi Al Utooria Strret,Khaled.";
  

    frameset = _LBL_address.frame;
    frameset.origin.y = _LBL_designation.frame.origin.y + _LBL_designation.frame.size.height+4;
   // frameset.size.height = _LBL_address.frame.origin.y + _LBL_address.intrinsicContentSize.height;
    _LBL_address.frame = frameset;
    
     [_LBL_address sizeToFit];
    
    
    
    frameset = _BTN_call.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height+4;
    _BTN_call.frame = frameset;
    
    _LBL_phone.text = @"PHONE:1234567891";
    
    frameset = _LBL_phone.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height+4;
    _LBL_phone.frame = frameset;

  //  [_LBL_phone sizeToFit];*/
    
//     frameset = _TXT_VW_address.frame;
//    frameset.size.height = _TXT_VW_address.frame.origin.y + _TXT_VW_address.contentSize.height;
//    _TXT_VW_address.frame = frameset;
    
    frameset = _BTN_call.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height;
    _BTN_call.frame = frameset;

    
    frameset =  _sub_VW_main.frame;
    frameset.size.height = _LBL_phone.frame.origin.y + _LBL_phone.frame.size.height + 20;
    _sub_VW_main.frame = frameset;
    
    _sub_VW_main.layer.cornerRadius = 2.0f;
    
    frameset = _VW_segment.frame;
    frameset.origin.x = _sub_VW_main.frame.origin.x;
    frameset.origin.y = _sub_VW_main.frame.origin.y + _sub_VW_main.frame.size.height;
    frameset.size.width = _sub_VW_main.frame.size.width;
    _VW_segment.frame = frameset;
    
    [_TBL_offers reloadData];
    
    frameset = _TBL_offers.frame;
    frameset.origin.x = _VW_segment.frame.origin.x;
    frameset.origin.y = _VW_segment.frame.origin.y + _VW_segment.frame.size.height + 10;
    frameset.size.height = _TBL_offers.frame.origin.y + _TBL_offers.contentSize.height+10;
    frameset.size.width = _VW_segment.frame.size.width;
    _TBL_offers.frame = frameset;
    
    [self.VW_main addSubview:_TBL_offers];
    
    
     frameset = _mapView.frame;
    frameset.origin.x = _TBL_offers.frame.origin.x;
    frameset.origin.y = _TBL_offers.frame.origin.y;
    frameset.size.width = _TBL_offers.frame.size.width;
    frameset.size.height = 400;
    _mapView.frame = frameset;
    [self.VW_main addSubview:_mapView];
    _mapView.hidden = YES;
    
    
    frameset = _BTN_get_direction.frame;
    frameset.origin.x = _mapView.frame.origin.x + _mapView.frame.size.width - _BTN_get_direction.frame.size.width - 20;
    frameset.origin.y = _mapView.frame.origin.y + _mapView.frame.size.height - 40;
    _BTN_get_direction.frame = frameset;
  
    
    [self.VW_main addSubview:_BTN_get_direction];
    
      _BTN_get_direction.hidden = YES;


    
    frameset = _VW_main.frame;
    frameset.size.height = _TBL_offers.frame.origin.y + _TBL_offers.contentSize.height+10;
    frameset.size.width = _scroll_contents.frame.size.width;
    _VW_main.frame = frameset;
    
    scroll_ht = _VW_main.frame.origin.y + _VW_main.frame.size.height;
    

    
    
    [self.scroll_contents addSubview:_VW_main];
    [_BTN_back addTarget:self action:@selector(back_actions) forControlEvents:UIControlEventTouchUpInside];
    

    [self setting_the_segemnt_controller];
    self.segmentedControl4.selectedSegmentIndex = 0;

    [_BTN_favourite addTarget:self action:@selector(favourites_ACTION) forControlEvents:UIControlEventTouchUpInside];
    [_BTN_call addTarget:self action:@selector(call_ACTION) forControlEvents:UIControlEventTouchUpInside];
    //get_DIREction_action
    [_BTN_get_direction addTarget:self action:@selector(get_DIREction_action) forControlEvents:UIControlEventTouchUpInside];


    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [_scroll_contents layoutIfNeeded];
    _scroll_contents.contentSize = CGSizeMake(_scroll_contents.frame.size.width,scroll_ht);// + _VW_filter.frame.size.height);
    
    
}

#pragma Set up of segment controller

-(void)setting_the_segemnt_controller
{
    NSArray<UIImage *> *images = @[[UIImage imageNamed:@"services"],
                                   [UIImage imageNamed:@"map"],
                                   ];
    
    NSArray<UIImage *> *selectedImages = @[[UIImage imageNamed:@"services"],
                                           [UIImage imageNamed:@"map"],
                                          ];
    NSArray<NSString *> *titles = @[@"services", @"Map"];
    
    _segmentedControl4= [[HMSegmentedControl alloc] initWithSectionImages:images sectionSelectedImages:selectedImages titlesForSections:titles];
    
    self.segmentedControl4.frame = _VW_segment.frame;
_segmentedControl4.imagePosition = HMSegmentedControlImagePositionAboveText;

self.segmentedControl4.sectionTitles = @[@"Services",@"Map"];
self.segmentedControl4.backgroundColor = [UIColor colorWithRed:0.16 green:0.53 blue:0.55 alpha:1.0];
self.segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15]};
self.segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:15]};
self.segmentedControl4.selectionIndicatorColor = [UIColor whiteColor];
self.segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
self.segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
self.segmentedControl4.selectionIndicatorHeight = 2.0f;


[self.segmentedControl4 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

[self.VW_main addSubview:self.segmentedControl4];
}
-(void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl4
{
    if(segmentedControl4.selectedSegmentIndex == 0)
    {
        [self Offers_view_showing];
    }
    else
    {
        [self map_view_calling];
    }
    
}
#pragma showing the offers view 

-(void)Offers_view_showing
{
      _BTN_get_direction.hidden = YES;
    [_TBL_offers reloadData];
    _mapView.hidden = YES;
    _TBL_offers.hidden = NO;
   CGRect frameset = _VW_main.frame;
    frameset.size.height = _TBL_offers.frame.origin.y + _TBL_offers.contentSize.height;
    _VW_main.frame = frameset;
    
    scroll_ht =  _VW_main.frame.origin.y + _VW_main.frame.size.height;
    
      [self viewDidLayoutSubviews];
    
    [UIView transitionWithView:_TBL_offers
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _TBL_offers.hidden = NO;
                    }
                    completion:NULL];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _mapView.hidden = YES;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_TBL_offers cache:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _mapView.hidden = YES;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_TBL_offers cache:YES];
    [UIView commitAnimations];


    
    
}
#pragma mark Map view calling

-(void)map_view_calling
{
    _TBL_offers.hidden = YES;
    _mapView.hidden= NO;
    _BTN_get_direction.hidden = NO;
    
    
    CGRect frameset = _VW_main.frame;
    frameset.size.height = _mapView.frame.origin.y + _mapView.frame.size.height ;
    _VW_main.frame = frameset;
    
    frameset = _BTN_get_direction.frame;
    frameset.origin.y = _mapView.frame.origin.y + _mapView.frame.size.height - 30;
    _BTN_get_direction.frame = frameset;
    
    scroll_ht =  _VW_main.frame.origin.y + _VW_main.frame.size.height;
    [self viewDidLayoutSubviews];
    
    [self map_VIEW_call];


}

#pragma map view calling
-(void)map_VIEW_call
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:15];
    [_mapView animateToCameraPosition:camera];
    _mapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = _mapView;
    
    [UIView transitionWithView:_mapView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        _TBL_offers.hidden = YES;
                    }
                    completion:NULL];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _mapView.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_mapView cache:YES];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"LeftFlip" context:nil];
    [UIView setAnimationDuration:0.4];
    _mapView.hidden = NO;
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:_mapView cache:YES];
    [UIView commitAnimations];
    
    
}


#pragma Table view delegates
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return Arr_ofrs_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    offers_cell *cell = (offers_cell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"offers_cell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.LBL_offer_names.text = [[Arr_ofrs_list objectAtIndex:indexPath.row] valueForKey:@"key1"];
    [cell.BTN_discout setTitle:[[Arr_ofrs_list objectAtIndex:indexPath.row] valueForKey:@"key2"] forState:UIControlStateNormal];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma back action
-(void)back_actions
{
    NSString *str_page = [[NSUserDefaults standardUserDefaults] valueForKey:@"tab_param"];
    [self.delegate detail_page_back:str_page];
    
}
#pragma favourites_action
-(void)favourites_ACTION
{
    [self.delegate favourites_ACTION];
}
-(void)get_DIREction_action
{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Acess denied" message:@"Please enable location services to proceed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
        
    }
    else{
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = 100.0;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager startUpdatingLocation];
    }

}
#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    CLLocation *LOC_current = newLocation;
    
    manager.delegate = nil;
    
    
    @try {
        NSString *STR_ship_LAT = @"12.9592";
        NSString *STR_ship_LON = @"77.6974";
        
        NSString *URL_STR = [NSString stringWithFormat:@"comgooglemaps://?center=%f,%f&q=%f,%f",LOC_current.coordinate.latitude,LOC_current.coordinate.longitude, [STR_ship_LAT floatValue],[STR_ship_LON floatValue]];
        
        
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
            NSURL *url = [NSURL URLWithString:URL_STR];
            [[UIApplication sharedApplication] openURL:url];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please install google map from itunes" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            [alert show];
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception from location %@",exception);
        /*  NSString *urlString=[NSString stringWithFormat:@"comgooglemaps://?center=%f,%f&zoom=14&views=traffic",LOC_current.coordinate.latitude,LOC_current.coordinate.longitude];
         if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
         [[UIApplication sharedApplication] openURL:
         [NSURL URLWithString:urlString]];
         } else {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please install google map from itunes" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
         [alert show];
         } */
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Destination location not available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}
#pragma mark Mobile _call

-(void)call_ACTION
{
    NSString *phone_number;
    @try {
        phone_number = @"9866806505";
    } @catch (NSException *exception) {
        NSLog(@"No phone number available %@",exception);
    }
    
    if (phone_number) {
        NSURL *phoneUrl = [NSURL URLWithString:[NSString  stringWithFormat:@"telprompt:%@",phone_number]];
        if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
            [[UIApplication sharedApplication] openURL:phoneUrl];
        } else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Call facility is not available!!!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Phone number not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
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
