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
#import "APIHelper.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface VC_detail ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    float scroll_ht;
    NSMutableArray *Arr_ofrs_list;
    NSDictionary *jsonresponse_DIC;
    CLLocationManager *locationManager;
}
@property (nonatomic, strong) HMSegmentedControl *segmentedControl4;

@end

@implementation VC_detail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [APIHelper start_animation:self];
    [self performSelector:@selector(Detail_API) withObject:nil afterDelay:0.01];

   
   }
#pragma setiing the frames for compnents

-(void)SET_UP_VIEW
{
    [self.BTN_favourite setTitle:[APIHelper set_count:[[NSUserDefaults standardUserDefaults] valueForKey:@"wish_count"]] forState:UIControlStateNormal];

    NSString *str_image = [NSString stringWithFormat:@"%@",[[jsonresponse_DIC valueForKey:@"Providers"]valueForKey:@"logo"]];
    
    [_IMG_center_image sd_setImageWithURL:[NSURL URLWithString:str_image]
                           placeholderImage:[UIImage imageNamed:@"Image-placeholder-2.png"]];

    
    _IMG_center_image.layer.cornerRadius = _IMG_center_image.frame.size.width/2;
    _IMG_center_image.layer.masksToBounds =  YES;
    
    NSString *str_naeme = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[jsonresponse_DIC valueForKey:@"Providers"] valueForKey:@"provider_name"]]];
    str_naeme = [str_naeme uppercaseString];

    
    _LBL_center_name.text = str_naeme;
    [_LBL_center_name sizeToFit];
    _LBL_header.text = str_naeme;
    
     NSString *str_speciality = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[jsonresponse_DIC valueForKey:@"Providers"] valueForKey:@"specialities"]]];
    
    _LBL_designation.text = str_speciality;
    CGRect frameset = _LBL_designation.frame;
    frameset.origin.y = _LBL_center_name.frame.origin.y + _LBL_center_name.frame.size.height+4;
    _LBL_designation.frame = frameset;
    
    
     NSString *str_address = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[jsonresponse_DIC valueForKey:@"Providers"] valueForKey:@"address"]]];
    
    _LBL_address.text = str_address;
  

    frameset = _LBL_address.frame;
    frameset.origin.y = _LBL_designation.frame.origin.y + _LBL_designation.frame.size.height+4;
    _LBL_address.frame = frameset;
    
     [_LBL_address sizeToFit];
    
    
    
    frameset = _BTN_call.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height+4;
    _BTN_call.frame = frameset;
    
    NSString *str_phone = [NSString stringWithFormat:@"%@",[[jsonresponse_DIC valueForKey:@"Providers"] valueForKey:@"contact_no"]];
    
    str_phone = [NSString stringWithFormat:@"PHONE : %@",[APIHelper convert_NUll:str_phone]];
    

    _LBL_phone.text = str_phone;
    
    frameset = _LBL_phone.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height+4;
    _LBL_phone.frame = frameset;

    
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

    [self viewDidLayoutSubviews];

    
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
#pragma Segment controller did select action

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
    double latititude = [[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"latitude"] doubleValue];
    double langitude = [[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"longitude"] doubleValue];

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latititude
                                                            longitude:langitude
                                                                 zoom:15];
    [_mapView animateToCameraPosition:camera];
    _mapView.myLocationEnabled = YES;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latititude, langitude);
    marker.title =[NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"provider_name"]]];
    marker.snippet = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"address"]]];
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
    
    NSInteger count = 0;
    if([[jsonresponse_DIC valueForKey:@"Services"] isKindOfClass:[NSArray class]])
    {
        count = [[jsonresponse_DIC valueForKey:@"Services"] count];
    }
    else{
        count = 0;
    }
    return count;
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
    
    NSString *str_offer_name = [NSString stringWithFormat:@"%@", [[[jsonresponse_DIC valueForKey:@"Services"] objectAtIndex:indexPath.row] valueForKey:@"service_name"]];
    str_offer_name = [APIHelper convert_NUll:str_offer_name];
    cell.LBL_offer_names.text =str_offer_name;
    
    NSString *str_dicount = [NSString stringWithFormat:@"%@",[[[jsonresponse_DIC valueForKey:@"Services"] objectAtIndex:indexPath.row] valueForKey:@"offer_type"]];
    if([str_dicount isEqualToString:@"Percentage"])
    {
        NSString *str = @"%";
        str_dicount = [NSString stringWithFormat:@"%@%@",[[[jsonresponse_DIC valueForKey:@"Services"] objectAtIndex:indexPath.row] valueForKey:@"offer_value"],str];
    }
    else{
        str_dicount = [NSString stringWithFormat:@"%@",str_dicount];
    }
    [cell.BTN_discout setTitle:str_dicount forState:UIControlStateNormal];
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
        double latititude = [[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"latitude"] doubleValue];
        double langitude = [[[jsonresponse_DIC valueForKey:@"Providers"]  valueForKey:@"longitude"] doubleValue];

        NSString *STR_ship_LAT = [NSString stringWithFormat:@"%f",latititude];
        NSString *STR_ship_LON =[NSString stringWithFormat:@"%f",langitude];
        
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
               
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Destination location not available" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
    
}
#pragma mark Mobile _call

-(void)call_ACTION
{
    NSString *phone_number;
    @try {
        phone_number = [NSString stringWithFormat:@"%@",[[jsonresponse_DIC valueForKey:@"Providers"] valueForKey:@"contact_no"]];
        phone_number = [NSString stringWithFormat:@"%@",[APIHelper convert_NUll:phone_number]];
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
#pragma mark Detail-API
-(void)Detail_API
{
    @try
    {
        NSHTTPURLResponse *response = nil;
        NSError *error;
        NSString *str_id =[NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"category_ID"]];
        NSString *str_provider_ID = [NSString stringWithFormat:@"%@", [[NSUserDefaults standardUserDefaults] valueForKey:@"provider_ID"]];
        NSString  *URL_STR = [NSString stringWithFormat:@"%@getProvidersDetails/%@/%@",SERVER_URL,str_id,str_provider_ID];
        
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
            jsonresponse_DIC =(NSDictionary *)[NSJSONSerialization JSONObjectWithData:aData options:NSASCIIStringEncoding error:&error];
            NSLog(@"%@",jsonresponse_DIC);
            [self SET_UP_VIEW];
            
            
        }
        else
        {
            [APIHelper createaAlertWithMsg:@"Connection error" andTitle:@""];
        }
    }
    @catch(NSException *Exception)
    {
        
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
