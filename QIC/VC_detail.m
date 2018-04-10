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

@interface VC_detail ()<UITableViewDelegate,UITableViewDataSource>
{
    float scroll_ht;
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
    _IMG_center_image.layer.cornerRadius = _IMG_center_image.frame.size.width/2;
    _IMG_center_image.layer.masksToBounds =  YES;
    
    _LBL_center_name.text = @"Al shami medical center";
    [_LBL_center_name sizeToFit];
    
    _LBL_designation.text = @"Dentist";
    [_LBL_designation sizeToFit];
    CGRect frameset = _LBL_designation.frame;
    frameset.origin.y = _LBL_center_name.frame.origin.y + _LBL_center_name.frame.size.height;
    _LBL_designation.frame = frameset;
    
    
    _LBL_address.text = @"Al shami medical center,Al shami medical centerAl shami medical center";
    [_LBL_address sizeToFit];

    frameset = _LBL_address.frame;
    frameset.origin.y = _LBL_designation.frame.origin.y + _LBL_designation.frame.size.height;
    _LBL_address.frame = frameset;
    
    
    
    frameset = _BTN_call.frame;
    frameset.origin.y = _LBL_address.frame.origin.y + _LBL_address.frame.size.height+4;
    _BTN_call.frame = frameset;
    
    _LBL_phone.text = @"PHONE:1234567891";
    [_LBL_phone sizeToFit];
    
    frameset = _LBL_phone.frame;
    frameset.origin.y = _BTN_call.frame.origin.y - 10;
    _LBL_phone.frame = frameset;
    
    frameset =  _sub_VW_main.frame;
    frameset.size.height = _LBL_phone.frame.origin.y + _LBL_phone.frame.size.height + 10;
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
    return 10;
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
